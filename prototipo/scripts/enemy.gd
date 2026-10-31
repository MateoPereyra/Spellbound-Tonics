class_name Enemy extends CharacterBody2D

@onready var attack_cd: Timer = $AttackCD
@onready var anim: AnimatedSprite2D = $AnimatedSprite2D

@export var velocidad := 100
@export var rango := 100
@export var health := 100
@export var damage := 5
@export var loot : ItemDefinition

var direction := Vector2.ZERO
var destino : Vector2
var has_destino := false
var espera := false
var enemie_on_sight := false
var objetive : Node2D
var attacking := false
