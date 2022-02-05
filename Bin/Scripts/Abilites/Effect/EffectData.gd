extends Resource
class_name EffectData

export (String,"Damage","Health","Speed") var StatEffect = "Health"
# If EffectModifier is true it means it will affect only the caster
export (bool) var SelfEffect = true
export (String,"Boost","Weeken","Poison") var EffectModifier = "Boost"
export (float) var EffectLength = 1.00
export (float) var EffectStrengh = 5.00

