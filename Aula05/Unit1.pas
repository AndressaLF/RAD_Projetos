unit Unit1;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, REST.Types,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  Data.Bind.Controls, FMX.Controls.Presentation, FMX.StdCtrls, FMX.Layouts,
  FMX.Objects, Fmx.Bind.Navigator, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, REST.Response.Adapter, REST.Client, Data.Bind.Components,
  Data.Bind.ObjectScope, Data.Bind.EngExt, Fmx.Bind.DBEngExt, System.Rtti,
  System.Bindings.Outputs, Fmx.Bind.Editors, Data.Bind.DBScope,
  System.Net.URLClient, System.Net.HttpClient, System.Net.HttpClientComponent;

type
  TForm1 = class(TForm)
    RESTClient1: TRESTClient;
    RESTRequest1: TRESTRequest;
    RESTResponse1: TRESTResponse;
    RESTResponseDataSetAdapter1: TRESTResponseDataSetAdapter;
    FDMemTable1: TFDMemTable;
    FDMemTable1id: TFloatField;
    FDMemTable1email: TWideStringField;
    FDMemTable1first_name: TWideStringField;
    FDMemTable1last_name: TWideStringField;
    FDMemTable1avatar: TWideStringField;
    BindNavigator1: TBindNavigator;
    Circle1: TCircle;
    Layout1: TLayout;
    GridPanelLayout1: TGridPanelLayout;
    Label1: TLabel;
    lbcod: TLabel;
    Label3: TLabel;
    lbname: TLabel;
    Label5: TLabel;
    lblastname: TLabel;
    Label7: TLabel;
    lbemail: TLabel;
    BindSourceDB1: TBindSourceDB;
    BindingsList1: TBindingsList;
    LinkPropertyToFieldText: TLinkPropertyToField;
    LinkPropertyToFieldText2: TLinkPropertyToField;
    LinkPropertyToFieldText3: TLinkPropertyToField;
    LinkPropertyToFieldText4: TLinkPropertyToField;
    NetHTTPClient1: TNetHTTPClient;
    procedure FormCreate(Sender: TObject);
    procedure FDMemTable1AfterScroll(DataSet: TDataSet);
  private
    procedure CarregarFoto(url: string);
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.fmx}

procedure TForm1.CarregarFoto(url: string);
var
  ms: TMemoryStream;
  resp: IHTTPResponse;
begin
  Circle1.Fill.Kind := TBrushKind.Bitmap;
  if url <> EmptyStr then
  begin
    ms := TMemoryStream.Create();
    try
      resp := NetHTTPClient1.Get(url, ms);
      if resp.StatusCode = 200 then
      begin
        ms.Position := 0;
        Circle1.Fill.Bitmap.Bitmap.LoadFromStream(ms);
      end;
    finally
      ms.Free;
    end;
  end;
end;

procedure TForm1.FDMemTable1AfterScroll(DataSet: TDataSet);
begin
  CarregarFoto(FDMemTable1avatar.AsString);
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  RESTRequest1.Execute;
end;

end.
