class_name ItemData extends Resource

#enum ItemType { LOOT, POTION } ESTOS COMENTADOS LOS ACOMODO DESPUES
#Hay que acomodar varias cosas, hubo cambios (?

@export var scene : PackedScene
@export var name : String
@export var efectos : Array[EffectData] = []
#@export var item_type : ItemType
