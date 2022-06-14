<%@ Page Language="vb" AutoEventWireup="true" CodeFile="Default.aspx.vb" Inherits="_Default" %>
<%@ Register Assembly="DevExpress.Web.v21.1, Version=21.1.9.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a"
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
		<table>
			<tr>
				<td>
					<dx:ASPxComboBox runat="server" ID="CmbCountry" DropDownStyle="DropDownList" DataSourceID="AccessDataSourceCountry"
						TextField="Country" ValueField="Country">
						<ClientSideEvents SelectedIndexChanged="function(s, e) { OnCountryChanged(s); }"></ClientSideEvents>
					</dx:ASPxComboBox>
				</td>
				<td>
					<dx:ASPxComboBox runat="server" ID="CmbCity" ClientInstanceName="cmbCity" OnCallback="CmbCity_Callback"
						DropDownStyle="DropDownList" DataSourceID="AccessDataSourceCities" TextField="City"
						ValueField="City">
					</dx:ASPxComboBox>
				</td>
			</tr>
		</table>
		<asp:AccessDataSource ID="AccessDataSourceCountry" runat="server" DataFile="~/App_Data/WorldCities.mdb"
			SelectCommand="SELECT * FROM [Countries]">
		</asp:AccessDataSource>
		<asp:AccessDataSource ID="AccessDataSourceCities" runat="server" DataFile="~/App_Data/WorldCities.mdb"
			SelectCommand="SELECT c.City FROM [Cities] c, [Countries] cr WHERE (c.CountryId = cr.CountryId) AND (cr.Country = ?) order by c.City">
			<SelectParameters>
				<asp:Parameter Name="?" />
			</SelectParameters>
		</asp:AccessDataSource>
	</form>
</body>
</html>