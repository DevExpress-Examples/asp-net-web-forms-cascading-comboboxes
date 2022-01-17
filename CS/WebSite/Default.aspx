<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="_Default" %>
<%@ Register Assembly="DevExpress.Web.v21.2, Version=21.2.4.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a"
    Namespace="DevExpress.Web" TagPrefix="dx" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <script type="text/javascript" language="javascript">
    function OnCountryChanged(cmbCountry) {
        cmbCity.PerformCallback(cmbCountry.GetSelectedItem().value.toString());
    }
    </script>
</head>
<body>
    <form id="form1" runat="server">
        <div style="display: flex; flex-direction: row; gap: 10px;">
            <div>
                <dx:ASPxLabel runat="server" Text="Country"/>
                <dx:ASPxComboBox runat="server" ID="CmbCountry" DropDownStyle="DropDownList" 
                    DataSourceID="CountryDataSource" TextField="Country" ValueField="Country">
                    <ClientSideEvents 
                        SelectedIndexChanged="function(s, e) { 
                            OnCountryChanged(s); 
                        }
                    "/>
                </dx:ASPxComboBox>
            </div>

            <div>
                <dx:ASPxLabel runat="server" Text="City"/>
                <dx:ASPxComboBox runat="server" ID="CmbCity" ClientInstanceName="cmbCity" OnCallback="CmbCity_Callback" DropDownStyle="DropDownList" 
                    DataSourceID="CityDataSource" TextField="City" ValueField="City">
                </dx:ASPxComboBox>
            </div>

        
        </div>

        <asp:SqlDataSource ID="CountryDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:WorldCitiesConnection %>" ProviderName="<%$ ConnectionStrings:WorldCitiesConnection.ProviderName %>" SelectCommand="SELECT * FROM [Countries]"/>
        <asp:SqlDataSource ID="CityDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:WorldCitiesConnection %>" ProviderName="<%$ ConnectionStrings:WorldCitiesConnection.ProviderName %>" SelectCommand="SELECT c.City FROM [Cities] c, [Countries] cr WHERE (c.CountryId = cr.CountryId) AND (cr.Country = ?) order by c.City">
            <SelectParameters>
                <asp:Parameter Name="?" />
            </SelectParameters>
        </asp:SqlDataSource>
    </form>
</body>
</html>