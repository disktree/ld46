package arm.node;

@:keep class DayCycle extends armory.logicnode.LogicTree {

	var functionNodes:Map<String, armory.logicnode.FunctionNode>;

	var functionOutputNodes:Map<String, armory.logicnode.FunctionOutputNode>;

	public function new() {
		super();
		this.functionNodes = new Map();
		this.functionOutputNodes = new Map();
		notifyOnAdd(add);
	}

	override public function add() {
		var _SetRotation = new armory.logicnode.SetRotationNode(this);
		_SetRotation.property0 = "Euler Angles";
		var _Print = new armory.logicnode.PrintNode(this);
		var _OnUpdate = new armory.logicnode.OnUpdateNode(this);
		_OnUpdate.property0 = "Update";
		_OnUpdate.addOutputs([_Print]);
		_Print.addInput(_OnUpdate, 0);
		var _Time = new armory.logicnode.TimeNode(this);
		var _Math = new armory.logicnode.MathNode(this);
		_Math.property0 = "Divide";
		_Math.property1 = "false";
		_Math.addInput(_Time, 0);
		_Math.addInput(new armory.logicnode.FloatNode(this, 3600.0), 0);
		var _Vector = new armory.logicnode.VectorNode(this);
		_Vector.addInput(new armory.logicnode.FloatNode(this, 0.0), 0);
		_Vector.addInput(new armory.logicnode.FloatNode(this, 0.0), 0);
		_Vector.addInput(_Math, 0);
		_Vector.addOutputs([_SetRotation]);
		_Math.addOutputs([_Vector]);
		_Time.addOutputs([_Print, _Math]);
		_Time.addOutputs([new armory.logicnode.FloatNode(this, 0.0)]);
		_Print.addInput(_Time, 0);
		_Print.addOutputs([_SetRotation]);
		_SetRotation.addInput(_Print, 0);
		_SetRotation.addInput(new armory.logicnode.ObjectNode(this, ""), 0);
		_SetRotation.addInput(_Vector, 0);
		_SetRotation.addInput(new armory.logicnode.FloatNode(this, 0.0), 0);
		_SetRotation.addOutputs([new armory.logicnode.NullNode(this)]);
	}
}