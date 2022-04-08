<%@ Page Title="" Language="C#" MasterPageFile="~/Light.master" AutoEventWireup="true" CodeBehind="ViewFile.aspx.cs" Inherits="FRS_File_App.ViewFile" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent"  runat="server">
    <dx:ASPxFileManager ID="fileManager" runat="server" Theme="Moderno" 
                       >
   <%--     <Settings  
                  AllowedFileExtensions=".csv"
                   />--%>
        <SettingsEditing AllowCreate="False" AllowDelete="False" AllowMove="False" AllowRename="False" AllowCopy="true" AllowDownload="true" />
        <SettingsPermissions>
            <AccessRules>
                <dx:FileManagerFolderAccessRule Path="System" Edit="Deny" />
                <dx:FileManagerFileAccessRule Path="System\*" Download="Deny" />
            </AccessRules>
        </SettingsPermissions>
        <SettingsFileList ShowFolders="false" ShowParentFolder="false" />
        <SettingsBreadcrumbs Visible="False" ShowParentFolderButton="False" Position="Top" />
     
    </dx:ASPxFileManager>
</asp:Content>
