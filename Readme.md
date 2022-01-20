<!-- default badges list -->
![](https://img.shields.io/endpoint?url=https://codecentral.devexpress.com/api/v1/VersionRange/128532327/13.1.4%2B)
[![](https://img.shields.io/badge/Open_in_DevExpress_Support_Center-FF7200?style=flat-square&logo=DevExpress&logoColor=white)](https://supportcenter.devexpress.com/ticket/details/E2355)
[![](https://img.shields.io/badge/📖_How_to_use_DevExpress_Examples-e9f6fc?style=flat-square)](https://docs.devexpress.com/GeneralInformation/403183)
<!-- default badges end -->
<!-- default file list -->
*Files to look at*:

* [Default.aspx](./CS/WebSite/Default.aspx) (VB: [Default.aspx](./VB/WebSite/Default.aspx))
* [Default.aspx.cs](./CS/WebSite/Default.aspx.cs) (VB: [Default.aspx.vb](./VB/WebSite/Default.aspx.vb))
<!-- default file list end -->
# Cascading Comboboxes for ASP.NET Web Forms
<!-- run online -->
**[[Run Online]](https://codecentral.devexpress.com/e2355/)**
<!-- run online end -->

This demo shows how to implement cascading [ASPxComboBoxes](https://docs.devexpress.com/AspNet/DevExpress.Web.ASPxComboBox).

![example demo](demo.gif)


The general technique for implementing cascading [ASPxComboBoxes](https://docs.devexpress.com/AspNet/DevExpress.Web.ASPxComboBox) is as follows:

1. Set up two [ASPxComboBoxes](https://docs.devexpress.com/AspNet/DevExpress.Web.ASPxComboBox) and assign data to them. This example uses [SqlDataSource](https://docs.microsoft.com/en-us/dotnet/api/system.web.ui.webcontrols.sqldatasource?view=netframework-4.8) to populate the comboboxes. The data source bound to the second combobox uses the [SelectParameters](https://docs.microsoft.com/en-us/dotnet/api/system.web.ui.webcontrols.sqldatasource.selectparameters?view=netframework-4.8) property to allow you to dynamically filter the data.
```xml
<dx:ASPxComboBox runat="server" ID="CountryCombo" ClientInstanceName="countryCombo" DataSourceID="CountryDataSource"...>
<dx:ASPxComboBox runat="server" ID="CityCombo" ClientInstanceName="cityCombo" DataSourceID="CityDataSource" OnCallback="CityCombo_Callback"...>

<asp:SqlDataSource ID="CountryDataSource" runat="server" ...
    SelectCommand="SELECT * FROM [Countries]"/>

<asp:SqlDataSource ID="CityDataSource" runat="server" ...
    SelectCommand="
        SELECT ct.City 
        FROM [Cities] ct, [Countries] cntr 
        WHERE (ct.CountryId = cntr.CountryId) AND (cntr.Country = @CountryName) 
            order by ct.City">
    <SelectParameters>
        <asp:Parameter Name="CountryName" />
    </SelectParameters>/>
```
2. Handle the client-side [SelectedIndexChanged](https://docs.devexpress.com/AspNet/js-ASPxClientComboBox.SelectedIndexChanged) event of the first [ASPxComboBox](https://docs.devexpress.com/AspNet/DevExpress.Web.ASPxComboBox). In this event's handler, call the second [ASPxComboBox](https://docs.devexpress.com/AspNet/DevExpress.Web.ASPxComboBox)'s [PerformCallback](https://docs.devexpress.com/AspNet/js-ASPxClientCallback.PerformCallback(parameter)) method to send a callback to the server and generate the server-side [Callback](https://docs.devexpress.com/AspNet/DevExpress.Web.ASPxCallback.Callback) event. Pass the first combobox's value to the server in a [callback parameter](https://docs.devexpress.com/AspNet/js-ASPxClientCallback.PerformCallback(parameter)#parameters).

```xml
<script>
    function OnCountryChanged(combo) {
        cityCombo.PerformCallback(combo.GetSelectedItem().value.toString());
    }
</script>
    ...
<dx:ASPxComboBox runat="server" ID="CountryCombo" ClientInstanceName="countryCombo" ...>
    <ClientSideEvents SelectedIndexChanged="function(s,e){OnCountryChanged(s);}"/>
    ...
```
3. In the server-side [Callback](https://docs.devexpress.com/AspNet/DevExpress.Web.ASPxCallback.Callback) event handler of the second [ASPxComboBox](https://docs.devexpress.com/AspNet/DevExpress.Web.ASPxComboBox), update the data source using the value passed in the [callback parameter](https://docs.devexpress.com/AspNet/js-ASPxClientCallback.PerformCallback(parameter)#parameters) as a filter.
``` c#
    protected void CityCombo_Callback(object source, DevExpress.Web.CallbackEventArgsBase e) {
        FillCityCombo(e.Parameter);
    }
    protected void FillCityCombo(string country) {
        if (string.IsNullOrEmpty(country)) return;
        
        //Update the data source bound to the second combobox.
        CityDataSource.SelectParameters["CountryName"].DefaultValue = country;
        CityCombo.DataBind();

        //Select the first city in a list.
        CityCombo.SelectedIndex = 0;
    }
```