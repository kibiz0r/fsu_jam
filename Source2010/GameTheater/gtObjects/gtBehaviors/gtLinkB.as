// gtBehavior.as 
package GameTheater.gtObjects.gtBehaviors
{
	import GameTheater.gtObjects.*;
	
	public dynamic class gtLinkB extends gtBehavior
	{
		public function gtLinkB()
		{
			m_name = "link";
			m_orderWeight = -1;
			//m_recycle = true;
		}
		
		public override function Awake()
		{
		}
		
		public override function Start()
		{
		}
		
		public override function Destructor()
		{
			for (var l in this)
			{
				if (l == "m_managed")
					continue;
				
				this[l].Destroy();
				this[l] = null;
				delete(this[l]);
			}
			
			super.Destructor();
		}
		
		public function Add(n)
		{
			if (this[n] == null)
				this[n] = new gtLink(n,gameObject);
			else
				trace("link exists already");
			return this[n];
		}
		
		public function Remove(n)
		{
			if (this[n] == null)
				return;
				
			this[n].Destroy();
			this[n] = null;
			delete(this[n]);
		}
	}
}