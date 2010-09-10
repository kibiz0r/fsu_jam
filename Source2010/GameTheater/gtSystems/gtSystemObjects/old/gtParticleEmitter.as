//psParticleEmitter
package GameTheater.gtSystems.gtSystemObjects
{
	import flash.display.*;
	import flash.events.*;
	import flash.utils.*;
	import flash.geom.*;
	
	import GameTheater.gtObjects.*;
	import GameTheater.gtSystems.*;
	import GameTheater.gtSystems.gtSystemObjects.*;
	import GameTheater.gtTools.*;
	import PinStriper.psObjects.*;
	import PinStriper.psSystems.*;
	import PinStriper.psTools.*;
	
	public class gtParticleEmitter extends Sprite
	{
		public var m_alive:Boolean = true;
		
		public var m_life:int = -100;
		
		public var m_behaviors:Array;
		
		public var m_particles:Array
		
		public var m_emitRate:int = 10;
		public var m_emitRemander = 0;
		
		public var m_pw:gtParticleWrangler;
		
		public function gtParticleEmitter()
		{
			m_pw = gtParticleWrangler.GetInstance();
			m_behaviors = new Array();
			m_particles = new Array();
			addEventListener(Event.ADDED_TO_STAGE,Added);
			addEventListener(Event.REMOVED_FROM_STAGE,Removed);
			AddBehavior(gtParticleMotionBehavior);
			AddBehavior(gtParticleLifeBehavior);
		}
		
		public function Added(e:Event)
		{
			//trace("added");
			if (e.target == this)
				addEventListener(Event.ENTER_FRAME,Update);
		}
		
		public function Removed(e:Event)
		{
			if (e.target == this)
			{
				//gtLog.Add("Alive: " + m_particles.length);
				for (var i:int = 0; i < m_particles.length; i++)
				{
					m_particles[i].parent.removeChild(m_particles[i]);
					m_pw.ReleaseParticle(m_particles[i]);
					m_particles[i] = null;
				}
				
				m_particles = null;
				m_behaviors = null;
				
				removeEventListener(Event.ENTER_FRAME,Update);
				removeEventListener(Event.ADDED_TO_STAGE,Added);
				removeEventListener(Event.REMOVED_FROM_STAGE,Removed);
			}
		}
		
		public function Update(e:Event)
		{
			if (m_life > -100)
				m_life -= gtTime.deltaT;
			if (m_life < 0 && m_life != -100)
				this.parent.removeChild(this);
			
			var emitAmount = m_emitRemander + (m_emitRate * (gtTime.deltaT*0.001))
			m_emitRemander = emitAmount - int(emitAmount);
																												   
			for (var i:int = 0; i < int(emitAmount); i++)
				Spawn();
			UpdateBehaviors(gtTime.deltaT);
		}
		
		public function UpdateBehaviors(deltaT:Number)
		{
			if (!this.m_alive)
				return;
				
			for (var i:* in m_behaviors)
			{
				for (var j:int = 0; j < m_particles.length; j++)
				{
					m_behaviors[i].Update(this,m_particles[j],deltaT);
					if (!m_particles[j].m_alive)
					{
						m_particles[j].parent.removeChild(m_particles[j]);
						m_pw.ReleaseParticle(m_particles[j]);
						m_particles.splice(j,1);
						j--;
					}
				}
			}
		}
		
		public function Spawn()
		{
			//return;
			var newParticle:gtParticle = m_pw.NewParticle();
			
			for (var i:* in m_behaviors)
			{
				m_behaviors[i].Init(this,newParticle);
			}
			newParticle.m_alive = true;
			m_particles.push(newParticle);
			//var temp = this.localToGlobal(new Point());
			//newParticle.x = temp.x;
			//newParticle.y = temp.y;
			//psEasel(psEasel.m_root).GetCanvas("main").addChild(newParticle);
			addChild(newParticle);
		}
		
		public function AddBehavior(b:Class)
		{
			var behavior = new b;
			//behavior.Init(this);
			//m_behavior.push(behavior);
			m_behaviors[getQualifiedClassName(behavior)] = behavior;
		}
	}
}