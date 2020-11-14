class_name Generator
extends Object


func _ready():
	pass

#ITEM GEN
static func gen_item_model(item: String) -> String:
	var text: String
	text = """{
	\"parent\": \"item/generated\",
	\"textures\": {
		\"layer0\": \""""+Global.MOD_ID+""":item/"""+item+"""\"
  }
}"""
	return text



#BLOCK GEN
static func gen_block_model(block: String,mode:int) -> String:
	if mode <= -1 :
		Global.handle_error("invalid Mode")
		assert(false)
	var text: String
	
	match mode:
		0:
			text = """{
  \"parent\": \"minecraft:block/cube_all\",
  \"textures\": {
	\"all\": \""""+Global.MOD_ID+""":block/"""+block+"""\"
  }
}"""
			return text
		1:
			text = """{
  \"parent\": \"minecraft:block/cube_column\",
  \"textures\": {
	\"end\": \""""+Global.MOD_ID+""":block/"""+block+"""_top\",
	\"side\": \""""+Global.MOD_ID+""":block/"""+block+"""\"
  }
}"""
			return text
		2:
			text ="""{
  \"parent\": \"minecraft:block/cross\",
  \"textures\": {
	\"cross\": \""""+Global.MOD_ID+""":block/"""+block+"""\"
  }
}"""
			return text
		3:
			text ="""{
  \"parent\": \"minecraft:block/template_anvil\",
  \"textures\": {
	\"top\": \""""+Global.MOD_ID+""":block/"""+block+"""_top\",
	\"body\": \""""+Global.MOD_ID+""":block/"""+block+"""_base\"
  }
}"""
			return text
	Global.handle_error("INVALID BLOCKMODE :"+ String(mode) +" FOR BLOCK MODEL GEN \nTHIS MEANS THAT THERE IS AN ISSUE IN THIS VERSION, THAT IS MY FAULT SORRY :(")
	return ""

static func gen_itemblock_model(block: String) -> String:
	var text: String
	text = """{
  \"parent\": \""""+Global.MOD_ID+""":block/"""+block+"""\"
}"""
	return text

static func gen_blockstate(block: String,mode:int) -> String:
	if mode <= -1 :
		Global.handle_error("invalid Mode")
		assert(false)
	var text: String
	
	match mode:
		0,2:
			text = """{
  \"variants\": {
	\"\": {
	  \"model\": \""""+Global.MOD_ID+""":block/"""+block+"""\"
	}
  }
}"""
			return text
		1:
			text = """{
  \"variants\": {
	\"axis=x\": {
	  \"model\": \""""+Global.MOD_ID+""":block/"""+block+"""\",
	  \"x\": 90,
	  \"y\": 90
	},
	\"axis=y\": {
	  \"model\": \""""+Global.MOD_ID+""":block/"""+block+"""\"
	},
	\"axis=z\": {
	  \"model\": \""""+Global.MOD_ID+""":block/"""+block+"""\",
	  \"x\": 90
	}
  }
}"""
			return text
		3:
			text = """{
  \"variants\": {
	\"facing=east\": {
	  \"model\": \""""+Global.MOD_ID+""":block/"""+block+"""\",
	  \"y\": 270
	},
	\"facing=north\": {
	  \"model\": \""""+Global.MOD_ID+""":block/"""+block+"""\",
	  \"y\": 180
	},
	\"facing=south\": {
	  \"model\": \""""+Global.MOD_ID+""":block/"""+block+"""\"
	},
	\"facing=west\": {
	  \"model\": \""""+Global.MOD_ID+""":block/"""+block+"""\",
	  \"y\": 90
	}
  }
}"""
			return text
	
	Global.handle_error("INVALID BLOCKMODE :"+ String(mode) +" FOR BLOCKSTATE GEN \nTHIS MEANS THAT THERE IS AN ISSUE IN THIS VERSION, THAT IS MY FAULT SORRY :(")
	return ""

static func gen_lang_line(unlocname : String, locname : String, mode:int) -> String:
	var text : String = ""
	match mode :
		Global.LANGMODE.BLOCK:
			text = "\"block."+Global.MOD_ID+"."+unlocname+"\": \""+locname+"\""
			return text
		Global.LANGMODE.ITEM:
			text = "\"item."+Global.MOD_ID+"."+unlocname+"\": \""+locname+"\""
			return text
		Global.LANGMODE.ENTITY:
			text = "\"entity."+Global.MOD_ID+"."+unlocname+"\": \""+locname+"\""
			return text
		Global.LANGMODE.ITEMGROUP:
			text = "\"itemGroup."+Global.MOD_ID+"."+unlocname+"\": \""+locname+"\""
			return text
	Global.handle_error("INVALID LANGMODE :"+ String(mode) +" FOR LANG LINE GEN \nTHIS MEANS THAT THERE IS AN ISSUE IN THIS VERSION, THAT IS MY FAULT SORRY :(")
	return""

static func gen_block_texture(block: String,mode:int,size:Vector2 = Vector2(16,16)):
	match mode :
		Global.BLOCKMODE.BLOCK,Global.BLOCKMODE.CROSS:
			Imager.save_empty_png("src/main/resources/assets/"+Global.MOD_ID+"/textures/block/"+block,size)
			return
		Global.BLOCKMODE.PILLAR:
			Imager.save_empty_png("src/main/resources/assets/"+Global.MOD_ID+"/textures/block/"+block+"_top",size)
			Imager.save_empty_png("src/main/resources/assets/"+Global.MOD_ID+"/textures/block/"+block,size)
			return
		Global.BLOCKMODE.ANVIL:
			Imager.save_empty_png("src/main/resources/assets/"+Global.MOD_ID+"/textures/block/"+block+"_top",size)
			Imager.save_empty_png("src/main/resources/assets/"+Global.MOD_ID+"/textures/block/"+block+"_base",size)
			return
	Global.handle_error("INVALID BLOCKMODE :"+ String(mode) +"FOR BLOCK TEXTURE GEN \nTHIS MEANS THAT THERE IS AN ISSUE IN THIS VERSION, THAT IS MY FAULT SORRY :(")
	




static func gen_class(type:int,mode:int,name:String) -> String:
	if name == "":
		Global.handle_error("Class Name is empty")
		return ""
	match type:
		Global.CLASSGENMODE.BLOCK:
			return gen_block_class(mode,name)
	Global.handle_error("INVALID CLASS TYPE :"+ String(type) +"FOR CLASS GEN \nTHIS MEANS THAT THERE IS AN ISSUE IN THIS VERSION, THAT IS MY FAULT SORRY :(")
	return ""



static func gen_block_class(mode:int,name:String) -> String:
	
	match mode:
		Global.BLOCKMODE.BLOCK:
			return gen_block_normal_class(name)
		Global.BLOCKMODE.PILLAR:
			return gen_block_pillar_class(name)
		Global.BLOCKMODE.CROSS:
			return gen_block_cross_class(name)
		Global.BLOCKMODE.ANVIL:
			return gen_block_anvil_class(name)
	Global.handle_error("INVALID BLOCK TYPE :"+ String(mode) +"FOR BLOCK CLASS GEN \nTHIS MEANS THAT THERE IS AN ISSUE IN THIS VERSION, THAT IS MY FAULT SORRY :(")
	return ""




static func gen_block_normal_class(name:String) -> String:
	var package = StringHelper.path_to_package(Global.java_gen_path)
	var text ="""package """+package+""".blocks;

import net.minecraft.block.Block;

public class """+name+""" extends Block {

	public """+name+"""(Settings settings) {
		super(settings);
	}
}"""
	return text



static func gen_block_pillar_class(name:String) -> String:
	var package = StringHelper.path_to_package(Global.java_gen_path)
	var text ="""package """+package+""".blocks;

import net.minecraft.block.Block;
import net.minecraft.block.BlockState;
import net.minecraft.item.ItemPlacementContext;
import net.minecraft.state.property.EnumProperty;
import net.minecraft.state.property.Properties;
import net.minecraft.state.property.Property;
import net.minecraft.util.BlockRotation;
import net.minecraft.util.math.Direction.Axis;
import net.minecraft.state.StateManager;

public class """+name+""" extends Block {

	public static final EnumProperty<Axis> AXIS = Properties.AXIS;

	public """+name+"""(Settings settings) {
		super(settings);
		this.setDefaultState(this.stateManager.getDefaultState().with(AXIS, Axis.Y));
	}

	@Override
	public BlockState rotate(BlockState state, BlockRotation rotation) {
		switch(rotation) {
			case COUNTERCLOCKWISE_90:
			case CLOCKWISE_90:
				switch(state.get(AXIS)) {
					case X:
						return state.with(AXIS, Axis.Z);
					case Z:
						return state.with(AXIS, Axis.X);
					default:
						return state;
				}
			default:
				return state;
		}
	}

	protected void appendProperties(StateManager.Builder<Block, BlockState> builder) {
		builder.add(new Property[]{AXIS});
	}

	public BlockState getPlacementState(ItemPlacementContext ctx) {
		return this.getDefaultState().with(AXIS, ctx.getSide().getAxis());
	}
}"""
	return text



static func gen_block_cross_class(name:String) -> String:
	var package = StringHelper.path_to_package(Global.java_gen_path)
	var text ="""package """+package+""".blocks;

import net.minecraft.block.*;
import net.minecraft.util.math.BlockPos;
import net.minecraft.util.shape.VoxelShape;
import net.minecraft.world.BlockView;

public class """+name+""" extends Block {
	private static final VoxelShape SHAPE = Block.createCuboidShape(2.0D, 0.0D, 2.0D, 14.0D, 13.0D, 14.0D);

	public """+name+"""(Settings settings) {
		super(settings);
	}

	@Override
	public VoxelShape getOutlineShape(BlockState state, BlockView world, BlockPos pos, ShapeContext context) {
		return SHAPE;
	}
}"""
	return text



static func gen_block_anvil_class(name:String) -> String:
	var package = StringHelper.path_to_package(Global.java_gen_path)
	var text ="""package """+package+""".blocks;

import net.minecraft.block.*;
import net.minecraft.item.ItemPlacementContext;
import net.minecraft.state.StateManager;
import net.minecraft.state.property.DirectionProperty;
import net.minecraft.state.property.Property;
import net.minecraft.util.BlockRotation;
import net.minecraft.util.math.BlockPos;
import net.minecraft.util.math.Direction;
import net.minecraft.util.shape.VoxelShape;
import net.minecraft.util.shape.VoxelShapes;
import net.minecraft.world.BlockView;

public class """+name+""" extends Block {
	
	public static final DirectionProperty FACING = HorizontalFacingBlock.FACING;
	private static final VoxelShape BASE_SHAPE = Block.createCuboidShape(2.0D, 0.0D, 2.0D, 14.0D, 4.0D, 14.0D);
	private static final VoxelShape X_STEP_SHAPE = Block.createCuboidShape(3.0D, 4.0D, 4.0D, 13.0D, 5.0D, 12.0D);
	private static final VoxelShape X_STEM_SHAPE = Block.createCuboidShape(4.0D, 5.0D, 6.0D, 12.0D, 10.0D, 10.0D);
	private static final VoxelShape X_FACE_SHAPE = Block.createCuboidShape(0.0D, 10.0D, 3.0D, 16.0D, 16.0D, 13.0D);
	private static final VoxelShape Z_STEP_SHAPE = Block.createCuboidShape(4.0D, 4.0D, 3.0D, 12.0D, 5.0D, 13.0D);
	private static final VoxelShape Z_STEM_SHAPE = Block.createCuboidShape(6.0D, 5.0D, 4.0D, 10.0D, 10.0D, 12.0D);
	private static final VoxelShape Z_FACE_SHAPE = Block.createCuboidShape(3.0D, 10.0D, 0.0D, 13.0D, 16.0D, 16.0D);
	private static final VoxelShape X_AXIS_SHAPE = VoxelShapes.union(BASE_SHAPE, new VoxelShape[]{X_STEP_SHAPE, X_STEM_SHAPE, X_FACE_SHAPE});
	private static final VoxelShape Z_AXIS_SHAPE = VoxelShapes.union(BASE_SHAPE, new VoxelShape[]{Z_STEP_SHAPE, Z_STEM_SHAPE, Z_FACE_SHAPE});
	
	
	
	public """+name+"""(Settings settings) {
		super(settings);
		this.setDefaultState(this.stateManager.getDefaultState().with(FACING, Direction.NORTH));
	}
	
	public BlockState getPlacementState(ItemPlacementContext ctx) {
		return this.getDefaultState().with(FACING, ctx.getPlayerFacing().rotateYClockwise());
	}

	@Override
	public BlockState rotate(BlockState state, BlockRotation rotation) {
		return state.with(FACING, rotation.rotate(state.get(FACING)));
	}
	
	@Override
	public VoxelShape getOutlineShape(BlockState state, BlockView world, BlockPos pos, ShapeContext context) {
		Direction direction = state.get(FACING);
		return direction.getAxis() == Direction.Axis.X ? X_AXIS_SHAPE : Z_AXIS_SHAPE;
	}
	
	protected void appendProperties(StateManager.Builder<Block, BlockState> builder) {
		builder.add(new Property[]{FACING});
	}
}"""
	return text
	
