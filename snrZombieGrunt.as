package
{
	import GameTheater.gtObjects.gtBehavior;

	public dynamic class snrZombieGrunt extends gtBehavior
	{
		
		
		public function snrZombieGrunt()
		{
			m_name = "gob";
		}
		
		public override function Awake()
		{
			gameObject.content = new Zombie_Grunt();
		}
		
		public override function Start()
		{
			trace("Start");
		}
	}
}