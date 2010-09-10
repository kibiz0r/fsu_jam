// gtObject.as 
package GameTheater.gtObjects
{
	import flash.display.MovieClip;
	import flash.display.DisplayObject;
	import flash.events.*;
	import flash.utils.*;
	
	import GameTheater.gtObjects.*;
	import GameTheater.gtObjects.gtBehaviors.*;
	import GameTheater.gtSystems.*;
	import GameTheater.gtSystems.gtSystemObjects.*;
	import GameTheater.gtTools.*;
	import flash.display.Sprite;
	
	public dynamic class gtGameObject extends gtObject
	{
		public const GO:String = "gtGameObject";
		
		private var m_behaviors:Array = new Array();
		
		public var m_report = false;
		
		private var m_startBehavioursListen:Boolean = false;
		private static var m_startBehaviours:int = 0;
		
		private var m_content = null;
		
		private var _link:gtLinkB;
		private var _mapper:gtMapperB;
		private var _states:gtStatesB;
		private var _properties:gtPropertiesB;
		private var _portal:gtPortalB;
		private var _values:gtValuesB;
		private var _actions:gtActionsB;
		private var _triggers:gtTriggersB;
		private var _actor:gtActorB;
		private var _screens:gtScreenB;
		private var _camera:gtCameraB;
		private var _ui:gtUIB;
		private var _tag:gtTagB;
		private var _tween:gtTweenB;
		private var _entity:gtEntityB;
		private var _collider:gtColliderB;
		private var _grid:gtGridB;
		private var _tile:gtTileB;
		private var _bucket:gtBucketB;
		private var _loader:gtLoaderB;
		
		public function get link():gtLinkB
		{
			if (_link == null)
				AddBehavior(gtLinkB);
			return _link;
		}
		
		public function set link(b)
		{
			if (_link == null)
				_link = b;
		}
		
		public function get mapper():gtMapperB
		{
			if (_mapper == null)
				AddBehavior(gtMapperB);
			return _mapper;
		}
		
		public function set mapper(b)
		{
			if (_mapper == null)
				_mapper = b;
		}
		
		public function get states():gtStatesB
		{
			if (_states == null)
				AddBehavior(gtStatesB);
			return _states;
		}
		
		public function set states(b)
		{
			if (_states == null)
				_states = b;
		}
		
		public function get properties():gtPropertiesB
		{
			if (_properties == null)
				AddBehavior(gtPropertiesB);
			return _properties;
		}
		
		public function set properties(b)
		{
			if (_properties == null)
				_properties = b;
		}
		
		public function get portal():gtPortalB
		{
			if (_portal == null)
				AddBehavior(gtPortalB);
			return _portal;
		}
		
		public function set portal(b)
		{
			if (_portal == null)
				_portal = b;
		}
		
		public function get values():gtValuesB
		{
			if (_values == null)
				AddBehavior(gtValuesB);
			return _values;
		}
		
		public function set values(b)
		{
			if (_values == null)
				_values = b;
		}
		
		public function get actions():gtActionsB
		{
			if (_actions == null)
				AddBehavior(gtActionsB);
			return _actions;
		}
		
		public function set actions(b)
		{
			if (_actions == null)
				_actions = b;
		}
		
		public function get triggers():gtTriggersB
		{
			if (_triggers == null)
				AddBehavior(gtTriggersB);
			return _triggers;
		}
		
		public function set triggers(b)
		{
			if (_triggers == null)
				_triggers = b;
		}
		
		public function get actor():gtActorB
		{
			if (_actor == null)
				AddBehavior(gtActorB);
			return _actor;
		}
		
		public function set actor(b)
		{
			if (_actor == null)
				_actor = b;
		}
		
		public function get screens():gtScreenB
		{
			if (_screens == null)
				AddBehavior(gtScreenB);
			return _screens;
		}
		
		public function set screens(b)
		{
			if (_screens == null)
				_screens = b;
		}
		
		public function get camera():gtCameraB
		{
			if (_camera == null)
				AddBehavior(gtCameraB);
			return _camera;
		}
		
		public function set camera(b)
		{
			if (_camera == null)
				_camera = b;
		}
		
		public function get ui():gtUIB
		{
			if (_ui == null)
				AddBehavior(gtUIB);
			return _ui;
		}
		
		public function set ui(b)
		{
			if (_ui == null)
				_ui = b;
		}
		
		public function get tag():gtTagB
		{
			if (_tag == null)
				AddBehavior(gtTagB);
			return _tag;
		}
		
		public function set tag(b)
		{
			if (_tag == null)
				_tag = b;
		}
		
		public function get tween():gtTweenB
		{
			if (_tween == null)
				AddBehavior(gtTweenB);
			return _tween;
		}
		
		public function set tween(b)
		{
			if (_tween == null)
				_tween = b;
		}
		
		public function get loader():gtLoaderB
		{
			if (_loader == null)
				AddBehavior(gtLoaderB);
			return _loader;
		}
		
		public function set loader(b)
		{
			if (_loader == null)
				_loader = b;
		}
		
		public function get entity():gtEntityB
		{
			if (_entity == null)
				AddBehavior(gtEntityB);
			return _entity;
		}
		
		public function set entity(b)
		{
			if (_entity == null)
				_entity = b;
		}
		
		public function get collider():gtColliderB
		{
			if (_collider == null)
				AddBehavior(gtColliderB);
			return _collider;
		}
		
		public function set collider(b)
		{
			if (_collider == null)
				_collider = b;
		}
		
		public function get grid():gtGridB
		{
			if (_grid == null)
				AddBehavior(gtGridB);
			return _grid;
		}
		
		public function set grid(b)
		{
			if (_grid == null)
				_grid = b;
		}
		
		public function get tile():gtTileB
		{
			if (_tile == null)
				AddBehavior(gtTileB);
			return _tile;
		}
		
		public function set tile(b)
		{
			if (_tile == null)
				_tile = b;
		}
		
		public function get bucket():gtBucketB
		{
			if (_bucket == null)
				AddBehavior(gtBucketB);
			return _bucket;
		}
		
		public function set bucket(b)
		{
			if (_bucket == null)
				_bucket = b;
		}
		
		public function gtGameObject()
		{
			//m_recycle = true;
		}
		
		// Content
		
		public function get content()
		{
			if (m_content == null)
				content = new Sprite();
			return m_content;
		}
		
		public function set content(c)
		{
			if (m_content != null)
			{
				removeChild(m_content);
				m_content = null;
			}
			m_content = c;
			if (m_content != null)
				addChild(m_content);
		}
		
		// Controls
		public function SendMessage(m,p,sender = null)
		{
			var s = "";
			if (sender != null)
				s = sender.m_name;
				
			if (this[m] != null)
			{
				if (p == null)
					this[m]()
				else
					this[m](p);
			}
			
			for (var i:int = 0; i < m_behaviors.length; i++)
			{
				//trace("send attempt",this.gob,m_behaviors[i].m_name,s,m_behaviors[i][m]);
				if ((m_behaviors[i].m_name == "gob" && m_behaviors[i] != sender) || m_behaviors[i].m_name != s)
				{
					//trace("send",this.gob,m,m_behaviors[i].m_name,s);
					if  (m_behaviors[i][m] != null)
					{
						if (p == null)
							m_behaviors[i][m]()
						else
							m_behaviors[i][m](p);
					}
				}
				//else
					//trace("send failed",this.gob,m,m_behaviors[i].m_name,s);
					
			}
		}
		
		public function DispatchMessage(m,p,sender = null)
		{
			//trace("dispatch",this.gob,m);
			SendMessage(m,p,sender);
			var children:Array = new Array();
			for (var i:int = 0; i < numChildren; i++)
			{
				var child = getChildAt(i);
				if (child.hasOwnProperty("type") && child.type == "gtGameObject")
				{
					children.push(child);
				}
			}
			
			for (i = 0; i < children.length; i++)
			{
				gtGameObject(children[i]).DispatchMessage(m,p,sender);
			}
		}
		
		public override function Enable()
		{
			super.Enable();
			/*AddBehavior(gtLinkB);
			AddBehavior(gtMapperB);
			AddBehavior(gtStatesB);
			AddBehavior(gtPropertiesB);
			AddBehavior(gtValuesB);
			AddBehavior(gtActionsB);
			AddBehavior(gtTriggersB);
			AddBehavior(gtActorB);*/
		}
		
		public override function Reset()
		{
			DestroyBehaviors();
			content = null;
			m_destroy = false;
			super.Reset();
		}
		
		public override function Destructor()
		{
			DestroyBehaviors();
			content = null;
			m_destroy = false;
			super.Destructor();
		}
		
		public function get alive()
		{
			return !m_destroy;
		}
		
		private var m_destroy:Boolean = false;
		public override function Destroy()
		{
			if (!m_destroy)
			{
				//trace("Queue up " + type);
				m_destroy = true;
				gtCore.AddEventListener(Event.RENDER,DestroyObject);
				gtCore.InvalidateDisplay();
			}
		}
		
		public function DestroyObject(e:Event)
		{
			//trace("Destroy " + type);
			gtCore.RemoveEventListener(Event.RENDER,DestroyObject);
			super.Destroy();
		}
		
		// Behavior Controls
		public function AddBehavior(B)
		{
			var behavior = gtObjects.Create(B);//new B;
			behavior.gameObject = this;
			m_behaviors.push(behavior);
			m_behaviors.sortOn("m_orderWeight",Array.NUMERIC);
			this[behavior.m_name] = behavior;
			behavior.Awake();
			
			if (!m_startBehavioursListen)
			{
				gtCore.AddEventListener(Event.RENDER,StartBehaviors);
				m_startBehavioursListen = true;
			}
			
			if (m_startBehaviours == 0)
			{
				gtCore.InvalidateDisplay();
			}
			
			m_startBehaviours++;
			
			return behavior;
		}
		
		public function StartBehaviors(e:Event)
		{
			for (var i:int = 0; i < m_behaviors.length; i++)
			{
				if (!m_behaviors[i].m_started)
				{
					m_startBehaviours--;
					m_behaviors[i].Start();
					m_behaviors[i].m_started = true;
				}
			}
			
			if (m_startBehavioursListen == true)
			{
				m_startBehavioursListen = false;
				gtCore.RemoveEventListener(Event.RENDER,StartBehaviors);
			}
			
			//if (m_startBehaviours == 0)
		}
		
		public function RemoveBehavior(b)
		{
			this["_"+b.m_name].Destroy();
			m_behaviors.splice(m_behaviors.indexOf(this["_"+b.m_name]),1);
			this["_"+b.m_name] = null;
		}
		
		public function DestroyBehaviors()
		{
			for (var i:int = m_behaviors.length-1; i > -1 ; i--)
			{
				//trace("Destroying Behavior " + m_behaviors[i].type);
				m_behaviors[i].Destroy();
				this["_"+m_behaviors[i].m_name] = null;
				m_behaviors[i] = null;
			}
			m_behaviors = new Array();
		}
	}
}