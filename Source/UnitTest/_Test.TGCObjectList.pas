unit _Test.TGCObjectList;
{

  Delphi DUnit Test Case
  ----------------------
  This unit contains a skeleton test case class generated by the Test Case Wizard.
  Modify the generated code to correctly setup and call the methods from the unit
  being tested.

}

interface

uses
  TestFramework, Tid.GCObject;

type
  // Test methods for class TGCObjectList

  TestTGCObjectList = class(TTestCase)
  strict private
    FGCObjectList: TGCObjectList;
  public
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure TestAdd;
    procedure TestClear;
    procedure TestDelete;
    procedure TestIsEmpty;
  end;

  TestGCObject = class(TTestCase)
  public
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure TestGC1;
    procedure TestGC2;
  end;

implementation

procedure TestTGCObjectList.SetUp;
begin
  FGCObjectList := TGCObjectList.Create;
end;

procedure TestTGCObjectList.TearDown;
begin
  FGCObjectList.Free;
  FGCObjectList := nil;
end;

procedure TestTGCObjectList.TestAdd;
var
  Obj: TGCObject;
begin
  Obj := TGCObject.Create(nil);
  FGCObjectList.Add(Obj);

  CheckFalse(FGCObjectList.IsEmpty);
  CheckTrue(FGCObjectList.Head^.Next^.Data = Obj);
end;

procedure TestTGCObjectList.TestClear;
var
  Obj: TGCObject;
begin
  Obj := TGCObject.Create(nil);
  FGCObjectList.Add(Obj);

  CheckFalse(FGCObjectList.IsEmpty);
  FGCObjectList.Clear;
  CheckTrue(FGCObjectList.IsEmpty);
end;

procedure TestTGCObjectList.TestDelete;
var
  Obj: TGCObject;
begin
  Obj := TGCObject.Create(nil);
  FGCObjectList.Add(Obj);

  CheckFalse(FGCObjectList.IsEmpty);
  FGCObjectList.Delete(Obj);
  CheckTrue(FGCObjectList.IsEmpty);
end;

procedure TestTGCObjectList.TestIsEmpty;
var
  Obj: TGCObject;
begin
  CheckTrue(FGCObjectList.IsEmpty);

  Obj := TGCObject.Create(nil);
  FGCObjectList.Add(Obj);

  CheckFalse(FGCObjectList.IsEmpty);
  FGCObjectList.Clear;
  CheckTrue(FGCObjectList.IsEmpty);
end;

{ TestGCObject }

procedure TestGCObject.SetUp;
begin
end;

procedure TestGCObject.TearDown;
begin
  TGCObject.GCManager.GarbageCollectFull;
end;

procedure TestGCObject.TestGC1;
const
  num = 10000;
var
  i: Integer;
begin
  TGCObject.LocalBegin;
  for i := 1 to num do
    TGCObject.Create(nil);
  TGCObject.LocalEnd;
end;

procedure TestGCObject.TestGC2;
var
  a, b, c, d: TGCTableObject;
begin
  a := TGCTableObject.Create(TGCTableObject.Create(TGCTableObject.Create(nil)));
  b := TGCTableObject.Create(TGCTableObject.Create(nil));
  a.GCRefObjects.Add(b);
  c := TGCTableObject.Create(a);
  b.GCRefObjects.Add(c);
  d := TGCRootObject.Create;
  TGCTableObject.Create(d);
  b.GCRefObjects.Add(TGCTableObject.Create(d));
  TGCObject.GCManager.GCRoots.Delete(d);
end;

initialization
  RegisterTest(TestTGCObjectList.Suite);
  RegisterTest(TestGCObject.Suite);

end.

