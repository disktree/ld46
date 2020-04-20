package arm.node;

@:keep class Gallery extends armory.logicnode.LogicTree {

	var functionNodes:Map<String, armory.logicnode.FunctionNode>;

	var functionOutputNodes:Map<String, armory.logicnode.FunctionOutputNode>;

	public function new() {
		super();
		this.functionNodes = new Map();
		this.functionOutputNodes = new Map();
		notifyOnAdd(add);
	}

	override public function add() {
		var _RotateObjectAroundAxis = new armory.logicnode.RotateObjectAroundAxisNode(this);
		var _ArrayLoop = new armory.logicnode.ArrayLoopNode(this);
		var _OnUpdate = new armory.logicnode.OnUpdateNode(this);
		_OnUpdate.property0 = "Update";
		_OnUpdate.addOutputs([_ArrayLoop]);
		_ArrayLoop.addInput(_OnUpdate, 0);
		var _Collection = new armory.logicnode.GroupNode(this);
		_Collection.property0 = "Gallery";
		_Collection.addOutputs([_ArrayLoop]);
		_ArrayLoop.addInput(_Collection, 0);
		_ArrayLoop.addOutputs([_RotateObjectAroundAxis]);
		_ArrayLoop.addOutputs([_RotateObjectAroundAxis]);
		_ArrayLoop.addOutputs([new armory.logicnode.NullNode(this)]);
		_RotateObjectAroundAxis.addInput(_ArrayLoop, 0);
		_RotateObjectAroundAxis.addInput(_ArrayLoop, 1);
		_RotateObjectAroundAxis.addInput(new armory.logicnode.VectorNode(this, 0.0, 0.0, 1.0), 0);
		_RotateObjectAroundAxis.addInput(new armory.logicnode.FloatNode(this, 0.009999999776482582), 0);
		_RotateObjectAroundAxis.addOutputs([new armory.logicnode.NullNode(this)]);
	}
}