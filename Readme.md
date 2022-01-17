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

This demo shows how to implement cascading comboboxes.

![example demo](demo.gif)

To implement cascading comboboxes do the following:

1. Create two comboboxes. The parent combobox (cmbCountry) dynamically populates the child combobox (cmbCity) with values, that correspond with the parent's currently selected item.
2. Create two data sources---the parent data source and the child data source---and bind them to the respective comboboxes.
3. Perform a callback on the child combobox in the parent's client-side SelectedIndexChanged event handler. Pass the new item's value to the server in a callback parameter.
``` xml
<dx:ASPxComboBox runat="server" ID="CmbCountry" DropDownStyle="DropDownList" 
    DataSourceID="CountryDataSource" TextField="Country" ValueField="Country">
    <ClientSideEvents 
        SelectedIndexChanged="function(s, e) { 
            OnCountryChanged(s); 
        }
    "/>
</dx:ASPxComboBox>
 ```

```js
function OnCountryChanged(cmbCountry) {
    cmbCity.PerformCallback(cmbCountry.GetSelectedItem().value.toString());
}
 ```

4. Update the child's data source with the new item's value. Bind the child combobox to the updated data source in the Callback handler. 
``` c#
protected void CmbCity_Callback(object source, DevExpress.Web.CallbackEventArgsBase e) {
    FillCityCombo(e.Parameter);
}

protected void FillCityCombo(string country) {
    if (string.IsNullOrEmpty(country)) return;
    CityDataSource.SelectParameters[0].DefaultValue = country;
    CmbCity.DataBind();
    CmbCity.SelectedIndex = 0;
}
```


