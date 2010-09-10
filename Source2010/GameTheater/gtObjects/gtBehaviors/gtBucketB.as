// gtBehavior.as 
package GameTheater.gtObjects.gtBehaviors
{
	import GameTheater.gtObjects.*;
	
	public dynamic class gtBucketB extends gtBehavior
	{
		private var _buckets:Object = new Object();
		
		public function gtBucketB()
		{
			m_name = "bucket";
			m_orderWeight = 0;
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
			for each(var bucket in _buckets)
			{
				Clear(bucket);
				_buckets[bucket] = null;
			}
			_buckets = new Object();
			super.Destructor();
		}
		
		public function Add(o,n)
		{
			if (_buckets[n] == null)
				_buckets[n] = new Array();
				
			_buckets[n].push(o);
		}
		
		public function Remove(o,n)
		{
			if (_buckets[n] == null)
				_buckets[n] = new Array();
				
			_buckets[n].splice(_buckets[n].indexOf(o),1);
		}
		
		public function Get(n)
		{
			if (_buckets[n] == null)
				_buckets[n] = new Array();
				
			return _buckets[n];
		}
		
		public function Clear(n)
		{
			if (_buckets[n] != null)
			{
				for (var i:int = 0; i < _buckets[n].length; i++)
					_buckets[n][i] = null;
			}
			
			_buckets[n] = new Array();
		}
	}
}