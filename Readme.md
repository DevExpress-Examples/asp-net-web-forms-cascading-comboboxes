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
 - Set up two [ASPxComboBoxes](https://docs.devexpress.com/AspNet/DevExpress.Web.ASPxComboBox) and assign data to them.
 - Call [PerformCallback](https://docs.devexpress.com/AspNet/js-ASPxClientCallback.PerformCallback(parameter)) method on the second [ASPxComboBox](https://docs.devexpress.com/AspNet/DevExpress.Web.ASPxComboBox). Pass the value of the first [ASPxComboBox](https://docs.devexpress.com/AspNet/DevExpress.Web.ASPxComboBox) in a [callback parameter](https://docs.devexpress.com/AspNet/js-ASPxClientCallback.PerformCallback(parameter)#parameters) to the server to filter the data for the second combobox.
 - Update the values of the second [ASPxComboBox](https://docs.devexpress.com/AspNet/DevExpress.Web.ASPxComboBox) in the server-side [Callback](https://docs.devexpress.com/AspNet/DevExpress.Web.ASPxCallback.Callback) event handler based on the value of the first [ASPxComboBox](https://docs.devexpress.com/AspNet/DevExpress.Web.ASPxComboBox) passed in a [callback parameter](https://docs.devexpress.com/AspNet/js-ASPxClientCallback.PerformCallback(parameter)#parameters).

To reproduce the cascading [ASPxComboBoxes](https://docs.devexpress.com/AspNet/DevExpress.Web.ASPxComboBox) implementation from this example, do the following:

1. Create two [ASPxComboBoxes](https://docs.devexpress.com/AspNet/DevExpress.Web.ASPxComboBox). The first [ASPxComboBox](https://docs.devexpress.com/AspNet/DevExpress.Web.ASPxComboBox) dynamically populates the second [ASPxComboBox](https://docs.devexpress.com/AspNet/DevExpress.Web.ASPxComboBox) with values, that correspond with the first [ASPxComboBox](https://docs.devexpress.com/AspNet/DevExpress.Web.ASPxComboBox)'s currently selected item. Bind these [ASPxComboBoxes](https://docs.devexpress.com/AspNet/DevExpress.Web.ASPxComboBox) to their respective data sources. Note that the [SqlDataSource](https://docs.microsoft.com/en-us/dotnet/api/system.web.ui.webcontrols.sqldatasource?view=netframework-4.8) bound to the second [ASPxComboBox](https://docs.devexpress.com/AspNet/DevExpress.Web.ASPxComboBox) uses the [SelectParameter](https://docs.microsoft.com/en-us/dotnet/api/system.web.ui.webcontrols.sqldatasource.selectparameters?view=netframework-4.8) to allow you to dynamically filter the data.
```xml
<dx:ASPxComboBox runat="server" ID="CountryCombo" ClientInstanceName="countryCombo" DataSourceID="CountryDataSource"...>
<dx:ASPxComboBox runat="server" ID="CityCombo" ClientInstanceName="cityCombo" DataSourceID="CityDataSource" OnCallback="CmbCity_Callback"...>

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

2. Call [PerformCallback](https://docs.devexpress.com/AspNet/js-ASPxClientCallback.PerformCallback(parameter)) on the second [ASPxComboBox](https://docs.devexpress.com/AspNet/DevExpress.Web.ASPxComboBox) in the first [ASPxComboBox](https://docs.devexpress.com/AspNet/DevExpress.Web.ASPxComboBox)'s client-side [SelectedIndexChanged](https://docs.devexpress.com/AspNet/js-ASPxClientComboBox.SelectedIndexChanged) event handler. Pass the new item's value to the server in a [callback parameter](https://docs.devexpress.com/AspNet/js-ASPxClientCallback.PerformCallback(parameter)#parameters).
``` xml
<script type="text/javascript" language="javascript">
    function OnCountryChanged(combo) {
        cityCombo.PerformCallback(combo.GetSelectedItem().value.toString());
    }
    
    ...

<dx:ASPxComboBox runat="server" ID="CountryCombo" ClientInstanceName="countryCombo" ...>
    <ClientSideEvents SelectedIndexChanged="function(s,e){OnCountryChanged(s);}"/>
    ...
 ```

3. Update the second [ASPxComboBox](https://docs.devexpress.com/AspNet/DevExpress.Web.ASPxComboBox)'s data source with the new item's value passed in a [callback parameter](https://docs.devexpress.com/AspNet/js-ASPxClientCallback.PerformCallback(parameter)#parameters). Bind the second [ASPxComboBox](https://docs.devexpress.com/AspNet/DevExpress.Web.ASPxComboBox) to the updated data source in the server-side [Callback](https://docs.devexpress.com/AspNet/DevExpress.Web.ASPxCallback.Callback) event handler. 
``` c#
    protected void CityCombo_Callback(object source, DevExpress.Web.CallbackEventArgsBase e) {
        FillCityCombo(e.Parameter);
    }
    protected void FillCityCombo(string country) {
        if (string.IsNullOrEmpty(country)) return;
        
        //Update the data source bound to the second combobox.
        CityDataSource.SelectParameters["CountryName"].DefaultValue = country;
        CityCombo.DataBind();

        //Select the first city in a list
        CityCombo.SelectedIndex = 0;
    }
```


