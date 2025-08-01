extends Node

@onready var SFX: Node = $SFX
@onready var InstanceHolder: Node = $InstanceHolder

var audio_lookup: Dictionary[StringName, AudioStreamPlayer]

var is_ready: bool = false

func _ready() -> void:
    _build_audio_lookup()
    get_tree().current_scene.connect("tree_exiting", exit_scene)
    is_ready = true

func exit_scene() -> void:
    for audio: AudioStreamPlayer in audio_lookup.values():
        audio.stop()
    for instance: AudioStreamPlayer in InstanceHolder.get_children():
        instance.stop()

func _build_audio_lookup() -> void:
    audio_lookup.clear()
    for type: Node in SFX.get_children():
        for audio: AudioStreamPlayer in type.get_children():
            var key: StringName = "%s:%s" % [type.name.to_lower(), audio.name.to_lower()]
            audio_lookup[key] = audio

func create_new_audio_instance(audio: AudioStreamPlayer) -> void:
    var new_instance := AudioStreamPlayer.new()
    new_instance.process_mode = audio.get_parent().process_mode
    new_instance.name = audio.name
    new_instance.stream = audio.stream
    new_instance.volume_db = audio.volume_db
    new_instance.pitch_scale = audio.pitch_scale
    new_instance.set_script(preload("res://Root/SFXManager/SFXInstance.gd"))
    InstanceHolder.add_child(new_instance)

func play(sfx: StringName, stop_and_play: bool = true, enable_instance: bool = false) -> void:
    sfx.to_lower()
    if audio_lookup.has(sfx):
        var audio: AudioStreamPlayer = audio_lookup[sfx]
        if stop_and_play:
            audio.play()
        elif not audio.playing:
            audio.play()
        elif enable_instance:
            call_deferred("create_new_audio_instance", audio)
    else:
        push_warning("SFX '%s' not found in audio_lookup." % sfx)

func stop(sfx: StringName) -> void:
    sfx.to_lower()
    if audio_lookup.has(sfx):
        var audio: AudioStreamPlayer = audio_lookup[sfx]
        audio.stop()

        for instance in InstanceHolder.get_children():
            if instance.name.begins_with(audio.name):
                instance.stop()
    else:
        push_warning("SFX '%s' not found in audio_lookup." % sfx)
