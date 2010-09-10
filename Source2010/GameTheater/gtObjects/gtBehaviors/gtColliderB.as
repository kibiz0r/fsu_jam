// gtUIB.as 
package GameTheater.gtObjects.gtBehaviors
{
	import GameTheater.gtObjects.*;
	import PinStriper.psSystems.psEasel;
	
	public dynamic class gtColliderB extends gtBehavior
	{
		public var m_collidableTags:Array = new Array();
		public var m_collider = null;
		
		
		public function gtColliderB()
		{
			m_name = "collider";
		}
		
		public override function Awake()
		{
			states.Add("CheckCollisions",CheckCollisions,"COLLIDE").Update();
		}
		
		public override function Start()
		{
			if (m_collider == null)
				m_collider = gameObject;
			states.Activate("CheckCollisions");
		}
		
		public override function Destructor()
		{
			states.DeactivateZone("COLLIDE")
			m_collider = null;
			m_collidableTags = new Array();
			super.Destructor();
		}
		
		public function AddCollisionCheck(t:String)
		{
			if (m_collidableTags.indexOf(t) == -1)
				m_collidableTags.push(t);
		}
		
		public function SetCollider(c)
		{
			
		}
		
		public function Collision(go)
		{
			SendMessage("Collision",go);
		}
		
		public function CheckCollisions(setting:int)
		{
			if (setting == gtState.UPDATE)
			{
				for (var i:int = 0; i < m_collidableTags.length; i++)
				{
					var objs = tag.GetObjects(m_collidableTags[i]);
					for each(var o in objs)
					{
						if (gameObject.alive && o.alive)
						{
							//trace(m_collider,o.collider.m_collider);
							if (m_collider.hitTestObject(o.collider.m_collider))
							{
								Collision(o);
								o.collider.Collision(gameObject);
							}
						}
					}
				}
			}
		}
	}
}