unit _Test.SmartPointer;
{

  Delphi DUnit Test Case
  ----------------------
  This unit contains a skeleton test case class generated by the Test Case Wizard.
  Modify the generated code to correctly setup and call the methods from the unit
  being tested.

}

interface

uses
  TestFramework, Tid.GCObject, Tid.GCObject.SmartPointer;

type
  // Test methods for class TSmartPointer
  TestTSmartPointer = class(TTestCase)
  strict private
    FSmartPointer: TSmartPointer;
  public
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure Test;
  end;

  // Test methods for class P<T>
  TestP = class(TTestCase)
  strict private
    FP: P<Integer>;
  public
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure Test;
  end;

implementation

procedure TestTSmartPointer.SetUp;
begin
  FSmartPointer := TSmartPointer.Create;
end;

procedure TestTSmartPointer.TearDown;
begin

end;

procedure TestTSmartPointer.Test;
var
  a: PByte;
begin
  New(a);
  FSmartPointer.Ptr := a;
  CheckTrue(FSmartPointer.Ptr = a);
end;

procedure TestP.SetUp;
begin
  FP := P<Integer>.Create;
end;

procedure TestP.TearDown;
begin

end;

procedure TestP.Test;
begin
  FP.Value := 3;
  CheckTrue(FP.Value = 3);
end;

initialization
  // Register any test cases with the test runner
  RegisterTest(TestTSmartPointer.Suite);
  RegisterTest(TestP.Suite);

end.

