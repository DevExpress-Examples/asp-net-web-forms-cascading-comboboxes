<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="_Default" %>
<%@ Register Assembly="DevExpress.Web.v21.1, Version=21.1.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a"
    Namespace="DevExpress.Web" TagPrefix="dx" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Cascading ASPxComboBoxes</title>
    <script>
        function OnCountryChanged(selectedValue) {
            cityCombo.PerformCallback(selectedValue);
        }
    </script>
</head>
<body>
    <form id="form1" runat="server">
        <div style="display: flex; flex-direction: row; gap: 10px;">
            <!--Country Combobox-->
            <div>
                <dx:ASPxComboBox runat="server" ID="CountryCombo" ClientInstanceName="countryCombo" DataSourceID="CountryDataSource"
                    DropDownStyle="DropDownList" TextField="Country" ValueField="Country" Caption="Country">
                    <ClientSideEvents SelectedIndexChanged="function(s,e){OnCountryChanged(s.GetSelectedItem().value.toString());}"/>
                </dx:ASPxComboBox>
            </div>

            <!--City Combobox-->
            <div>
                <dx:ASPxComboBox runat="server" ID="CityCombo" ClientInstanceName="cityCombo" DataSourceID="CityDataSource" OnCallback="CityCombo_Callback" TextField="City" ValueField="City" Caption="City"/>
            </div>
        </div>

        <!--Data Sources-->
        <asp:SqlDataSource ID="CountryDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:WorldCitiesConnection %>" ProviderName="<%$ ConnectionStrings:WorldCitiesConnection.ProviderName %>" SelectCommand="SELECT * FROM [Countries]"/>
        <asp:SqlDataSource ID="CityDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:WorldCitiesConnection %>" ProviderName="<%$ ConnectionStrings:WorldCitiesConnection.ProviderName %>" 
            SelectCommand="
                SELECT ct.City 
                FROM [Cities] ct, [Countries] cntr 
                WHERE (ct.CountryId = cntr.CountryId) AND (cntr.Country = @CountryName) 
                    order by ct.City">
            <SelectParameters>
                <asp:Parameter Name="CountryName" />
            </SelectParameters>
        </asp:SqlDataSource>
    
    </form>
</body>
</html>