// gtUIB.as 
package GameTheater.gtObjects.gtBehaviors
{
	import GameTheater.gtObjects.*;
	import GameTheater.gtTools.*;
	import PinStriper.psSystems.psEasel;
	
	public dynamic class gtUIB extends gtBehavior
	{
		public function gtUIB()
		{
			m_name = "ui";
		}
		
		public override function Awake()
		{
		}
		
		public override function Start()
		{
		}
		
		public override function Destructor()
		{
			//trace("gt uiB not cleaned up properly");
			super.Destructor();
		}
		
		public function AddInputText(n,tb)
		{
			if (this[n] != null)
			{
				trace("input text already exists");
				return;
			}
			
			this[n] = new gtInputText(n,tb,gameObject);
			return this[n];
		}
		
		public function NewInputText(n,T)
		{
			trace("this is broke i cant make you a text box you fool");
		}
		
		public function RemoveInputText(n)
		{
			if (this[n] != null)
			{
				if (this[n].created == true)
					this[n].parent.removeChild(this[n]);
				
				this[n].Destroy();
				this[n] = null;
			}
		}
		
		public function AddButton(n,b)
		{
			if (this[n] != null)
			{
				trace("button already exists",n);
				return;
			}
			
			this[n] = new gtButton(n,b,gameObject);
			return this[n];
		}
		
		public function NewButton(n,T)
		{
			if (this[n] != null)
				return;
			this[n] = new gtButton(n,new T(),gameObject);
			this[n].created = true;
			content.addChild(this[n].m_button);
			return this[n];
		}
		
		public function RemoveButton(n)
		{
			if (this[n] != null)
			{
				if (this[n].created == true)
					this[n].m_button.parent.removeChild(this[n].m_button);
				
				this[n].Destroy();
				this[n] = null;
			}
		}
		
		public function NewPopUp(n,T)
		{
			if (this[n] != null)
				return;
			this[n] = new gtPopUp(n,new T(),gameObject);
			var canvas = psEasel.GetCanvas("popup");
			if (canvas == null)
				gameObject.content.addChild(this[n].m_popup);
			else
			 	canvas.addChild(this[n].m_popup);
			return this[n];
		}
		
		public function NewGoPopUp(n,T)
		{
			if (this[n] != null)
				return;
			this[n] = new gtPopUp(n,gt.GO(T),gameObject);
			var canvas = psEasel.GetCanvas("popup");
			if (canvas == null)
				this[n].m_popup.actor.Attach(gameObject.content);
			else
			 	this[n].m_popup.actor.Attach(canvas);
			return this[n];
		}
		
		public function GetPopUp(n)
		{
			return this[n];
		}
		
		public function RemovePopUp(n)
		{
			if (this[n] != null)
			{
				this[n].m_popup.parent.removeChild(this[n].m_popup);
				if (this[n].m_popup.gob != null)
					this[n].m_popup.Destroy();
				this[n].Destroy();
				this[n] = null;
			}
		}
	}
}

/*ui.AddButton("test",land.testButton).Click().Hover();
ui.NewButton("test2",TestButton).Click().Hover();
		
public function Click(o)
{
	if (o.m_name == "test2")
		screens.ParentSwitch("levelSelect");
}
		s
public function MouseOver(o)
{
	//trace(o.m_name);
}

public function MouseOut(o)
{
	//trace(o.m_name);
}*/