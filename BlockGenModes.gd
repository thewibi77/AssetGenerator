extends OptionButton


func _ready():
	add_item ("Basic Block", Global.BLOCKMODE.BLOCK)
	add_item ("Log/Pillar", Global.BLOCKMODE.PILLAR)
	add_item ("Cross/Plant", Global.BLOCKMODE.CROSS)
	add_item ("Anvil", Global.BLOCKMODE.ANVIL)
