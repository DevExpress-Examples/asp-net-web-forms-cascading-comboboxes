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
# A general technique of using cascading ASPxComboBoxes
<!-- run online -->
**[[Run Online]](https://codecentral.devexpress.com/128532327/)**
<!-- run online end -->


<p>This demo illustrates a general technique of using cascading ASPxComboBoxes:</p>
<p>1) Handle the parent ASPxClientComboBox's <a href="http://documentation.devexpress.com/#AspNet/DevExpressWebASPxEditorsScriptsASPxClientComboBox_SelectedIndexChangedtopic">SelectedIndexChanged</a> event and perform the child ASPxComboBox's callback via the ASPxClientComboBox's <a href="http://documentation.devexpress.com/#AspNet/DevExpressWebASPxEditorsScriptsASPxClientComboBox_PerformCallbacktopic">PerformCallback</a> method;<br> 2) Handle the child ASPxComboBox's <a href="https://documentation.devexpress.com/#AspNet/DevExpressWebASPxAutoCompleteBoxBase_Callbacktopic">Callback</a> event and bind the child ASPxComboBox with the datasource, based on the parent ASPxComboBox's <a href="http://documentation.devexpress.com/#AspNet/DevExpressWebASPxEditorsASPxComboBox_SelectedItemtopic">SelectedItem</a> / <a href="http://documentation.devexpress.com/#AspNet/DevExpressWebASPxEditorsASPxComboBox_SelectedIndextopic">SelectedIndex</a> property.</p>

<br/>


