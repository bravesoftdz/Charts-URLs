unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls,
  IdHTTP,GIFImg, IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient,JPeg,System.Net.HttpClientComponent,
  System.Net.URLClient, System.Net.HttpClient, dxGDIPlusClasses,pngimage;

type
  TForm1 = class(TForm)
    Image1: TImage;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Edit4: TEdit;
    Edit5: TEdit;
    SpeedButton1: TSpeedButton;
    ComboBox1: TComboBox;
    EdTit: TEdit;
    Edit6: TEdit;
    Edit7: TEdit;
    Memo1: TMemo;
    NetHTTPClient1: TNetHTTPClient;
    procedure SpeedButton1Click(Sender: TObject);
    Procedure Charts(Tipo:string);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  vUrl:WideString;

implementation

{$R *.dfm}

function LoadStreamFromURL1(url : string): TMemoryStream;
var
        http : THTTPClient;
begin

    Result := TMemoryStream.Create;
    http := THTTPClient.Create;

    try

            try
                    // Evitar cache...
                    url := url + '?id=' + floattostr(Random);

                    http.Get(url, Result);

            except
            end;

            Result.Position := 0;
    finally
            http.DisposeOf;
    end;
end;


Procedure TForm1.Charts(Tipo:string);
VAR
    stream : TMemoryStream;
    bmp : TBitmap;
    vImage: TPngImage;

begin
   Memo1.Lines.Clear;

  if Tipo = 'line' then
  begin

      vUrl:='https://quickchart.io/chart?c={'
            +'type:''line'','
            +'data:{'
            +'labels:['+QuotedStr(Edit1.Text)+','+QuotedStr(Edit2.Text)+','+QuotedStr(Edit3.Text)+','+QuotedStr(Edit4.Text)+','+QuotedStr(Edit5.Text)+','+QuotedStr(Edit6.Text)+','+QuotedStr(Edit7.Text)+'],'
            +'datasets:['
            +'{'
            +'label:''Descrição1'','
            +'backgroundColor:''rgb(255,99,132)'','
            +'borderColor:''rgb(255,99,132)'','
            +'data:[93,-29,-17,-8,73,98,40],'
            +'fill:false,'
            +'},'
            +'{'
            +'label:''Descriçãodois'','
            +'fill:false,'
            +'backgroundColor:''rgb(54,162,235)'','
            +'borderColor:''rgb(54,162,235)'','
            +'data:[20,85,-79,93,27,-81,-22],'
            +'},'
            +'],'
            +'},'
            +'options:{'
            +'title:{'
            +'display:true,'
            +'text:'+QuotedStr(EdTit.text)+','
            +'},'
            +'},'
            +'}&f=.png';
 end;

  if Tipo = 'doughnut' then
  begin
    vUrl:= 'https://quickchart.io/chart?c={'
            +'type:''doughnut'','
            +'data:{'
            +'datasets:['
            +'{'
            +'data:[94,25,72,70,14],'
            +'backgroundColor:['
            +'''rgb(255,99,132)'','
            +'''rgb(255,159,64)'','
            +'''rgb(255,205,86)'','
            +'''rgb(75,192,192)'','
            +'''rgb(54,162,235)'','
            +'],'
            +'label:''Dataset1'','
            +'},'
            +'],'
            +'labels:['+QuotedStr(Edit1.Text)+','+QuotedStr(Edit2.Text)+','+QuotedStr(Edit3.Text)+','+QuotedStr(Edit4.Text)+','+QuotedStr(Edit5.Text)+'],'
            +'},'
            +'options:{'
            +'title:{'
            +'display:true,'
            +'text:'+QuotedStr(EdTit.text)+','
            +'},'
            +'},'
            +'}&f=.png';

  end;

    if Tipo = 'pie' then
  begin

    vUrl:='https://quickchart.io/chart?c={'
          +'type:''pie'','
          +'data:{'
          +'datasets:['
          +'{'
          +'data:[84,28,57,19,97],'
          +'backgroundColor:['
          +'''rgb(255,99,132)'','
          +'''rgb(255,159,64)'','
          +'''rgb(255,205,86)'','
          +'''rgb(75,192,192)'','
          +'''rgb(54,162,235)'','
          +'],'
          +'label:'+QuotedStr(EdTit.text)+','
          +'},'
          +'],'
          +'labels:['+QuotedStr(Edit1.Text)+','+QuotedStr(Edit2.Text)+','+QuotedStr(Edit3.Text)+','+QuotedStr(Edit4.Text)+','+QuotedStr(Edit5.Text)+'],'
          +'},'
          +'}&f=.png';
  end;

      if Tipo = 'bar' then
  begin

    vUrl:='https://quickchart.io/chart?c={'
          +'type:''bar'','
          +'data:{'
          +'labels:['+QuotedStr(Edit1.Text)+','+QuotedStr(Edit2.Text)+','+QuotedStr(Edit3.Text)+','+QuotedStr(Edit4.Text)+','+QuotedStr(Edit5.Text)+'],'
          +'datasets:[{'
          +'label:'+QuotedStr(EdTit.text)+','
          +'data:[120,60,50,180,120]'
          +'}]'
          +'}'
          +'}&f=.png';
  end;



    Memo1.Lines.Add(vUrl);

    stream := LoadStreamFromURL1(vUrl);
    vImage := TPngImage.Create;
     try

     vImage.LoadFromStream(Stream);
     Image1.Picture.Graphic := vImage;

     finally
     vImage.DisposeOf;
     stream.DisposeOf;
     end;


end;





procedure TForm1.SpeedButton1Click(Sender: TObject);
begin
   vUrl:=EmptyStr;
  case ComboBox1.ItemIndex of
    0: Charts('line');
    1: Charts('doughnut');
    2: Charts('pie') ;
    3: Charts('bar');
  end;

end;

end.
