# Exercise 5.1-FPS

Exercise for MSCH-C220

The expectations for this exercise are that you will

  - [ ] Fork and clone this repository
  - [ ] Import the project into Godot
  - [ ] Create a 3D Player with collision shapes and a camera
  - [ ] Add Inputs for Forward, Back, Left, Right, and Jump
  - [ ] Write a script so the player can move using the keyboard and mouse
  - [ ] Add, position, and add a material for a Shotgun mesh
  - [ ] Edit the LICENSE and README.md
  - [ ] Commit and push your changes back to GitHub. Turn in the URL of your repository on Canvas.

---

---

## Instructions

This exercise is a chance to play with Godot's 3D capability for the first time. We will be creating a simple first-person-controlled character and adding it to a simple 3D scene.

Fork this repository. When that process has completed, make sure that the top of the repository reads [your username]/Exercise-5-1-FPS. *Edit the LICENSE and replace BL-MSCH-C220 with your full name.* Commit your changes.

Clone the repository to a Local Path on your computer.

Open Godot. Import the project.godot file and open the "FPS" project.

This exercise is loosely based on the Godot 101: Intro to 3D tutorial by KidsCanCode. It was released as a [YouTube video](https://youtu.be/_55ktNdarxY), and a similar tutorial [has also been written out](http://kidscancode.org/godot_recipes/basics/3d/101_3d_07/). Please follow the directions I provide in this exercise, but if you get stuck or need additional context, feel free to consult the KidsCanCode tutorial.

In res://Game.tscn, I have provided a starting place for the exercise: the scene contains a parent Node3D node (named Game) and a StaticBody Ground node (containing a MeshInstance Plane and a CollisionShape). There are also WorldEnvironment and DirectionLight3D nodes to provide lighting.

Right-click on the Game node, and Add Child Node. Choose CharacterBody3D (not CharacterBody2D!). Name the new node Player

Right-click on the Player node, and Add Child Node. Choose CollisionShape. Name the new node Body

Right-click on the Player node again, and Add Child Node. Choose CollisionShape. Name the new node Feet

Right-click on the Player node again, and Add Child Node. Choose Node3D. Name the new node Pivot

Right-click on the Pivot node, and Add Child Node. Choose Camera3D.

Select the Body node. In the Inspector, select a new shape: New CapsuleShape. Edit the Shape; set the Radius to 0.5 and make sure the Height is 1. Go back to the Inspector for the Body node, and open Spatial->Transform. Set Translation->y to 1.6

Select the Feet node. In the Inspector, select a new shape: New BoxShape. Edit the Shape: set the size to x:0.8, y:0.2, z:0.8. Go back to the Inspector for the Foot node, and open Spatial->Transform. Set Translation->y to 0.8

Select the Pivot node. In the Inspector, Spatial->Transform, set Translation->y to 2

Select the Camera3D node. In the Inspector, set Current to On

Run the project, and make sure everything looks correct. Your perspective should be about two meters above a (relatively) small blue rectangle.

In the Project menu->Project Settings, select the Input Map tab. As previously, set up WASD+space keyboard controls to the following mappings: forward, left, back, right, jump. Close Project Settings

Right-click on the Player node, and Attach Script. Change the Template to Empty, and set the Path to res://Player/Player.gd

In the resulting Player.gd script, type the following:

```
extends CharacterBody3D


const SPEED = 5.0
const JUMP_VELOCITY = 4.5
const MOUSE_SENSITIVITY = 0.001
const MOUSE_RANGE = 1.2

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

func _unhandled_input(event):
	# if the mouse has moved
	if event is InputEventMouseMotion:
		# up-down motion, applied to the $Pivot
		$Pivot.rotate_x(-event.relative.y * MOUSE_SENSITIVITY)
		# make sure we can't look inside ourselves :)
		$Pivot.rotation.x = clamp($Pivot.rotation.x, -MOUSE_RANGE, MOUSE_RANGE)
		# left-right motion, applied to the Player
		rotate_y(-event.relative.x * MOUSE_SENSITIVITY)


func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta

	# Handle Jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()
```
(make sure to indent using tabs instead of spaces)

If you run the game again, you should now be able to move forward, back, strafe left and right, jump, and look around using the mouse. If you leave the platform, you should fall.

Finally, we will add a weapon. Right click on the Pivot node, and Add Child Node. Choose MeshInstance. Name the new node Gun. Select the Gun node.

In the Assets folder (in the FileSystem panel), you should see shotgun.obj. Drag that file to the Mesh property in the Inspector

Under Spatial->Transform, set Translation->x: 0.4, y: -0.2, z: -0.4. Set Rotation Degrees->x: 180 and Rotation Degrees->z: 180. Set Scale->x: 8, y: 8, z: 8

Under Surface Material Override, create a new StandardMaterial3D for material 0. Change the Albedo for that material to RGB->34,34,34 (dark gray). Copy that material and paste it in the other 31 materials.

If you run the game again, you should now be holding a gray gun.

Quit Godot. In GitHub desktop, add a summary message, commit your changes and push them back to GitHub. If you return to and refresh your GitHub repository page, you should now see your updated files with the time when they were changed.

Now edit the README.md file. When you have finished editing, commit your changes, and then turn in the URL of the main repository page (https://github.com/[username]/Exercise-5-1-FPS) on Canvas.

The final state of the file should be as follows (replacing the "Created by" information with your name):
```
# Exercise 5.1—FPS

Exercise for MSCH-C220

The first Godot 3D exercise, a simple first-person-controlled character.

## Implementation

Built using Godot 4.1.1

The shotgun model is from the [Weapon Pack](https://kenney.nl/assets/weapon-pack) at kenney.nl.

## References

None

## Future Development

None

## Created by 

Jason Francis
```
