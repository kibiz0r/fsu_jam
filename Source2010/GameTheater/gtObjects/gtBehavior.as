// gtBehavior.as 
package GameTheater.gtObjects
{
	import GameTheater.gtObjects.gtBehaviors.*;
	
	public class gtBehavior extends gtObject
	{
		public function get mapper():gtMapperB{return gameObject.mapper;}
		public function get states():gtStatesB{return gameObject.states;}
		public function get properties():gtPropertiesB{return gameObject.properties;}
		public function get portal():gtPortalB{return gameObject.portal;}
		public function get values():gtValuesB{return gameObject.values;}
		public function get actions():gtActionsB{return gameObject.actions;}
		public function get link():gtLinkB{return gameObject.link;}
		public function get entity():gtEntityB{return gameObject.entity;}
		public function get triggers():gtTriggersB{return gameObject.triggers;}
		public function get actor():gtActorB{return gameObject.actor;}
		public function get screens():gtScreenB{return gameObject.screens;}
		public function get camera():gtCameraB{return gameObject.camera;}
		public function get grid():gtGridB{return gameObject.grid;}
		public function get tile():gtTileB{return gameObject.tile;}
		public function get ui():gtUIB{return gameObject.ui;}
		public function get tag():gtTagB{return gameObject.tag;}
		public function get collider():gtColliderB{return gameObject.collider;}
		public function get tween():gtTweenB{return gameObject.tween;}
		public function get loader():gtLoaderB{return gameObject.loader;}	
		public function get bucket():gtBucketB{return gameObject.bucket;}
		
		public var gameObject = null;
		public var m_name:String = "gtBehavior";
		public var m_orderWeight:Number = 1;
		public var m_started = false;
		
		public function Awake()
		{
		}
		
		public function Start()
		{
		}
		
		public override function Reset()
		{
			//trace("reset",m_name);
			Destructor();
		}
		
		public override function Destructor()
		{
			gameObject = null;
		}
		
		public function SendMessage(m,p = null)
		{
			gameObject.SendMessage(m,p,this);
		}
		
		public function DispatchMessage(m,p = null)
		{
			gameObject.DispatchMessage(m,p,this);
		}
		
		public function AddBehavior(b)
		{
			return gameObject.AddBehavior(b);
		}
		
		public function get content()
		{
			return gameObject.content;
		}
		
		public function set content(c)
		{
			gameObject.content = c;
		}
	}
}