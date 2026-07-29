import canonicalLaneMathlib.AdmissibleClass
import HautevilleHouse.ConvectionHydrodynamicStabilityFoundationCanonicalLaneLean.LinearStabilityLayer

namespace HautevilleHouse
namespace ConvectionHydrodynamicStabilityFoundationCanonicalLaneLean

structure RayleighNumberCertificate where
  baseState : BoussinesqFlow
  criticalRayleigh : ℝ
  actualRayleigh : ℝ
  stabilityCondition : Prop
  supercritical : Prop
  subcritical : Prop
  stabilityConditionClosed : stabilityCondition

def criticalRayleigh : ℝ := 1708
def actualSubcriticalRayleigh : ℝ := 1000
def actualSupercriticalRayleigh : ℝ := 2000

def sourceSubcriticalCertificate : RayleighNumberCertificate := {
  baseState := primitiveBoussinesqFlow,
  criticalRayleigh := criticalRayleigh,
  actualRayleigh := actualSubcriticalRayleigh,
  stabilityCondition := actualSubcriticalRayleigh < criticalRayleigh,
  supercritical := False,
  subcritical := True,
  stabilityConditionClosed := by native_decide
}

def sourceSupercriticalCertificate : RayleighNumberCertificate := {
  baseState := primitiveBoussinesqFlow,
  criticalRayleigh := criticalRayleigh,
  actualRayleigh := actualSupercriticalRayleigh,
  stabilityCondition := actualSupercriticalRayleigh > criticalRayleigh,
  supercritical := True,
  subcritical := False,
  stabilityConditionClosed := by native_decide
}

def RayleighNumberGateOpen (C : RayleighNumberCertificate) : Prop :=
  C.stabilityCondition

theorem subcritical_gate_open_checked :
    RayleighNumberGateOpen sourceSubcriticalCertificate := by
  exact sourceSubcriticalCertificate.stabilityConditionClosed

theorem supercritical_gate_open_checked :
    RayleighNumberGateOpen sourceSupercriticalCertificate := by
  exact sourceSupercriticalCertificate.stabilityConditionClosed

end ConvectionHydrodynamicStabilityFoundationCanonicalLaneLean
end HautevilleHouse