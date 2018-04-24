extends KinematicBody2D

var movimento = Vector2()  #vetor de coordenadas no plano que serve de referencia para movimentação
var controlePulo = 0       #Controla o pulo duplo, adicinanado + 1 a cada pulo
var UP = Vector2(0,-1)     #Usando para detectar um chao. Resumindo, qualquer obstaculo que o corpo se encontrar sera considerado um chão (floor)
const pular = -400         #Força (altura) do pulo, quanto menor o valor mais alto pula
const VELOCIDADE = 200     #Velocidade do caminhar do personagem
const GRAVIDADE = 10       #Velocidade em que o personagem cai do ar



func _physics_process(delta):
	
	
	#Se estiver no chão a gravidade não o deixa infinitamente "pesado", se não a gravidade atua o puxando para baixo
	if is_on_floor():
		movimento.y = 0
		controlePulo = 0
	else:
		movimento.y += GRAVIDADE
	
	
	
	
	
	
	#ESTA PARTE DO CODIGO TRATA DO MOVIMENTO DO PERSONAGEM
	#PULANDO
	if Input.is_action_just_pressed("pular") && controlePulo < 2:
		movimento.y = pular
		controlePulo += 1
	
	#ANDANDO PARA ESQUERDA
	elif Input.is_action_pressed("esquerda"):
		movimento.x = -VELOCIDADE
	
	#ANDANDO PARA DIREITA
	elif Input.is_action_pressed("direita"):
		movimento.x = VELOCIDADE
	
	#FAZ COM QUE O PERSONAGEM NAO CONTINUE SE MOVENDO AO SOLTAR A TECLA USADA PARA ANDAR
	else:
		movimento.x = 0
	#FIM_MOVIMENTO
	
	
	
	
	
	
	#ESTA PARTE DO CODIGO TRATA DOS SPRITES
	if movimento.x > 0 && is_on_floor():
		$SpriteLink.set_animation("Correndo")
		get_node("SpriteLink").set_flip_h(false)
	elif movimento.x < 0 && is_on_floor():
		$SpriteLink.set_animation("Correndo")
		get_node("SpriteLink").set_flip_h(true)
	elif movimento.x == 0 && movimento.y == 0:
		$SpriteLink.set_animation("Parado")
	
	
	if movimento.y < 0:
		$SpriteLink.set_animation("Pulando")
	#elif movimento.y < 0:
	#	$SpriteLink.set_animation("Caindo")
	
	
	
	if Input.is_action_pressed("baixo"):
		$SpriteLink.set_animation("Abaixado")
	
	#FIM_SPRITES
	
	
	$SpriteLink.play()
	move_and_slide(movimento, UP)
