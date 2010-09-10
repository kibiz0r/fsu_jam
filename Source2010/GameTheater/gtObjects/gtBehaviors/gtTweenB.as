// gtUIB.as 
package GameTheater.gtObjects.gtBehaviors
{
	import GameTheater.gtObjects.*;
	import PinStriper.psSystems.psEasel;
	import fl.transitions.*;
	import fl.transitions.easing.*;
	
	public dynamic class gtTweenB extends gtBehavior
	{
		public var m_tweenables:Array = new Array();
		public function gtTweenB()
		{
			m_name = "tween";
		}
		
		public override function Awake()
		{
		}
		
		public override function Start()
		{
		}
		
		public override function Destructor()
		{
			for (var i:int = 0; i < m_tweenables.length; i++)
				Remove(m_tweenables[i]);
			m_tweenables = new Array();
			super.Destructor();
		}
		
		public function Clear()
		{
			for (var i:int = 0; i < m_tweenables.length; i++)
				Remove(m_tweenables[i]);
			m_tweenables = new Array();
		}
		
		public function Add(n,o,autoRemove:Boolean = false)
		{
			if (this[n] != null)
			{
				trace("tweenable already exists",n);
				return;
			}
			
			if (autoRemove)
				o.m_autoRemoveTween = true;
			m_tweenables.push(n);
			this[n] = o;
			return this[n];
		}
		
		public function Get(n)
		{
			return this[n];
		}
		
		public function Remove(n)
		{
			if (this[n] != null)
			{
				if (this[n].tweens != null)
				{
					for (var t in this[n].tweens)
					{
						if (t == "m_tweenName")
							continue;
						this[n].tweens[t].removeEventListener(TweenEvent.MOTION_FINISH,Finish);
						this[n].tweens[t].stop();
						this[n].tweens[t] = null;
						delete(this[n].tweens[t]);
					}
					this[n].tweens = null;
				}
				
				this[n] = null;
				delete(this[n]);
				return;
			}
		}
		
		public function Prop(n,p,s,e,t,f = null)
		{
			if (this[n] == null)
			{
				trace("tweenable does not exist",n);
				return;
			}
			
			if (this[n].tweens == null)
			{
				this[n].tweens = new Object();
				this[n].tweens.m_tweenName = n;
			}
			
			if (this[n].tweens[p] != null)
			{
				this[n].tweens[p].stop();
			}
			
			if (f == null)
				f = Regular.easeInOut;
			
			this[n].m_tweenCount++;
			this[n].tweens[p] = new Tween(this[n],p,f,s,e,t,true);
			this[n].tweens[p].addEventListener(TweenEvent.MOTION_FINISH,Finish);
			
			return this[n];
		}
		
		public function X(n,s,e,t = 1,f = null)
		{
			Prop(n,"x",s,e,t,f);
		}
		
		public function Y(n,s,e,t = 1,f = null)
		{
			Prop(n,"y",s,e,t,f);
		}
		
		public function Z(n,s,e,t = 1,f = null)
		{
			Prop(n,"z",s,e,t,f);
		}
		
		public function Alpha(n,s,e,t = 1,f = null)
		{
			Prop(n,"alpha",s,e,t,f);
		}
		
		public function Scale(n,s,e,t = 1,f = null)
		{
			Prop(n,"scaleX",s,e,t,f);
			Prop(n,"scaleY",s,e,t,f);
		}
		
		public function ScaleX(n,s,e,t = 1,f = null)
		{
			Prop(n,"scaleX",s,e,t,f);
		}
		
		public function ScaleY(n,s,e,t = 1,f = null)
		{
			Prop(n,"scaleY",s,e,t,f);
		}
		
		public function Rotation(n,s,e,t = 1,f = null)
		{
			Prop(n,"rotation",s,e,t,f);
		}
		
		public function Finish(e:TweenEvent)
		{
			e.currentTarget.obj.tweens[e.currentTarget.prop].removeEventListener(TweenEvent.MOTION_FINISH,Finish);
			e.currentTarget.obj.tweens[e.currentTarget.prop] = null;
			delete(e.currentTarget.obj.tweens[e.currentTarget.prop]);
			var temp = new Object();
			temp.m_name = e.currentTarget.obj.tweens.m_tweenName
			temp.m_prop = e.currentTarget.prop;
			temp.m_tween = e.currentTarget;
			temp.m_event = e;
			gameObject.SendMessage("MotionFinish",temp);
			gameObject.SendMessage("TweenEnd",temp);
			e.currentTarget.obj.m_tweenCount--;
			if (e.currentTarget.obj.m_autoRemoveTween)
			{
				if (e.currentTarget.obj.m_tweenCount == 0)
				{
					Remove(e.currentTarget.obj.tweens.m_tweenName);
				}
			}
		}
		
	}
}