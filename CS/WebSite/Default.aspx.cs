using System;

public partial class _Default : System.Web.UI.Page {
    protected void Page_Load(object sender, EventArgs e) {        
        if (!IsCallback) {
            CmbCountry.Value = "Mexico";
            FillCityCombo("Mexico");
        }
    }
    protected void CmbCity_Callback(object source, DevExpress.Web.CallbackEventArgsBase e) {
        FillCityCombo(e.Parameter);
    }
    protected void FillCityCombo(string country) {
        if (string.IsNullOrEmpty(country)) return;
        CityDataSource.SelectParameters[0].DefaultValue = country;
        CmbCity.DataBind();
        CmbCity.SelectedIndex = 0;
    }
}