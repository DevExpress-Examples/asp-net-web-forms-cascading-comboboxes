using System;

public partial class _Default : System.Web.UI.Page {
    protected void Page_Load(object sender, EventArgs e) {        
        //On the first page load, fill the comboboxes with "Mexico".
        if (!IsPostBack) {
            CountryCombo.Value = "Mexico";
            FillCityCombo("Mexico");
        }
    }
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
}