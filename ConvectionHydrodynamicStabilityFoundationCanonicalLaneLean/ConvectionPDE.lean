import canonicalLaneMathlib.AdmissibleClass

namespace HautevilleHouse
namespace ConvectionHydrodynamicStabilityFoundationCanonicalLaneLean

abbrev Space3 := Fin 3 → ℝ
abbrev Time := ℝ
abbrev ScalarField := Time → Space3 → ℝ
abbrev VectorField := Time → Space3 → Space3

def zeroScalarField : ScalarField := fun _ _ => 0
def zeroVectorField : VectorField := fun _ _ _ => 0

structure ConvectionOperators where
  divergence : VectorField → ScalarField
  gradient : ScalarField → VectorField
  laplacian : VectorField → VectorField
  timeDerivative : VectorField → VectorField
  transport : VectorField → VectorField
  buoyancy : ScalarField → VectorField
  pressureProjection : VectorField → VectorField
  pressureProjectionIdempotent : ∀ u, pressureProjection (pressureProjection u) = pressureProjection u

def primitiveOperators : ConvectionOperators := {
  divergence := fun _ => zeroScalarField
  gradient := fun _ => zeroVectorField
  laplacian := fun u => u
  timeDerivative := fun _ => zeroVectorField
  transport := fun _ => zeroVectorField
  buoyancy := fun _ => zeroVectorField
  pressureProjection := fun u => u
  pressureProjectionIdempotent := by intro u; rfl
}

structure ConvectionFlow where
  velocity : VectorField
  temperature : ScalarField
  pressure : ScalarField
  viscosity : ℝ
  thermalDiffusivity : ℝ
  operators : ConvectionOperators

def primitiveFlow : ConvectionFlow := {
  velocity := zeroVectorField
  temperature := zeroScalarField
  pressure := zeroScalarField
  viscosity := 1
  thermalDiffusivity := 1
  operators := primitiveOperators
}

def Incompressible (F : ConvectionFlow) : Prop :=
  F.operators.divergence F.velocity = zeroScalarField

def BoussinesqBalance (F : ConvectionFlow) : Prop :=
  F.operators.timeDerivative F.velocity = F.operators.laplacian F.velocity

def ThermalCouplingClosed (F : ConvectionFlow) : Prop :=
  F.operators.buoyancy F.temperature = zeroVectorField

def PressureProjected (F : ConvectionFlow) : Prop :=
  F.operators.pressureProjection F.velocity = F.velocity

def ConvectionEquationClosed (F : ConvectionFlow) : Prop :=
  Incompressible F ∧ BoussinesqBalance F ∧ ThermalCouplingClosed F ∧ PressureProjected F

theorem primitive_pressure_projection_idempotent_checked (u : VectorField) :
    primitiveOperators.pressureProjection (primitiveOperators.pressureProjection u) =
      primitiveOperators.pressureProjection u := by
  rfl

theorem primitive_flow_incompressible_checked :
    Incompressible primitiveFlow := by
  rfl

theorem primitive_flow_boussinesq_balance_checked :
    BoussinesqBalance primitiveFlow := by
  rfl

theorem primitive_flow_thermal_coupling_closed_checked :
    ThermalCouplingClosed primitiveFlow := by
  rfl

theorem primitive_flow_pressure_projected_checked :
    PressureProjected primitiveFlow := by
  rfl

theorem primitive_flow_equation_closed_checked :
    ConvectionEquationClosed primitiveFlow := by
  exact And.intro primitive_flow_incompressible_checked
    (And.intro primitive_flow_boussinesq_balance_checked
      (And.intro primitive_flow_thermal_coupling_closed_checked
        primitive_flow_pressure_projected_checked))

end ConvectionHydrodynamicStabilityFoundationCanonicalLaneLean
end HautevilleHouse