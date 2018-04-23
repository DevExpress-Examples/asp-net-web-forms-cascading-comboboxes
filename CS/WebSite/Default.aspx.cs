using System;

public partial class _Default : System.Web.UI.Page {
    protected void Page_Load(object sender, EventArgs e) {
        if (!IsCallback) {
            CmbCountry.Value = "Mexico";
            FillCityCombo("Mexico");
            CmbCity.SelectedIndex = 0;
        }
    }
    protected void CmbCity_Callback(object source, DevExpress.Web.ASPxClasses.CallbackEventArgsBase e) {
        FillCityCombo(e.Parameter);
    }
    protected void FillCityCombo(string country) {
        if (string.IsNullOrEmpty(country)) return;
        AccessDataSourceCities.SelectParameters[0].DefaultValue = country;
        CmbCity.DataBind();
    }
}