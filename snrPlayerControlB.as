package
{
	import GameTheater.gtObjects.gtBehavior;

	public dynamic class snrPlayerControlB extends gtBehavior
	{
		public function snrPlayerControlB()
		{
			m_name = "gob"
		}
		
		public override function Awake()
		{
			gameObject.content = new SamuraiNinjaRabbit();
		}
		
		public override function Start()
		{
			
		}
	}
}