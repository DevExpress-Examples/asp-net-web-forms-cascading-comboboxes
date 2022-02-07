Imports Microsoft.VisualBasic
Imports System

Partial Public Class _Default
	Inherits System.Web.UI.Page
	Protected Sub Page_Load(ByVal sender As Object, ByVal e As EventArgs)
		If (Not IsCallback) Then
			CmbCountry.Value = "Mexico"
			FillCityCombo("Mexico")
			CmbCity.SelectedIndex = 0
		End If
	End Sub
	Protected Sub CmbCity_Callback(ByVal source As Object, ByVal e As DevExpress.Web.CallbackEventArgsBase)
		FillCityCombo(e.Parameter)
	End Sub
	Protected Sub FillCityCombo(ByVal country As String)
		If String.IsNullOrEmpty(country) Then
			Return
		End If
		AccessDataSourceCities.SelectParameters(0).DefaultValue = country
		CmbCity.DataBind()
	End Sub
End Class