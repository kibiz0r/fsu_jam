// gtValuesB.as 
package GameTheater.gtObjects.gtBehaviors
{
	import GameTheater.gtObjects.*;
	
	public dynamic class gtValuesB extends gtBehavior
	{
		public function gtValuesB()
		{
			m_name = "values";
			m_orderWeight = -0.8;
		}
		
		public override function Awake()
		{
		}
		
		public override function Start()
		{
		}
		
		public override function Destructor()
		{
			for (var v in this)
			{
				if (this[v].hasOwnProperty("m_name") && this[v].m_name == v)
				{
					this[v].Destroy();
					this[v] = null;
					delete(this[v]);
				}
			}
			super.Destructor();
		}
		
		public function Add(n:String,v)
		{
			var value = new gtValue(n,v,gameObject);
			this[n] = value;
			return value;
		}
		
		public function Remove(n:String)
		{
			this[n].Destroy();
			this[n] = null;
			delete(this[n]);
		}
	}
}

// sample implementation
//public function get t(){return values.t.value;}
//public function set t(v){values.t.value = v;}


		