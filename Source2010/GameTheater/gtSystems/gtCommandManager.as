//gtCommandManager
package GameTheater.gtSystems
{
	import GameTheater.gtSystems.*;
	import GameTheater.gtSystems.gtSystemObjects.*;
	
	public class gtCommandManager
	{
		
		public static var m_instance = null;
		
		public var m_commands:Array;
		
		public function gtCommandManager()
		{
			m_commands = new Array();
			
			var man_com:gtCommand = NewCommand("man",man);
			man_com.AddParameter("what",String);
			man_com.Add_man("to use type man( \"command\" ) or man \"command\"");
			
			var help_com:gtCommand = NewCommand("help",help);
			help_com.Add_man("just type help");
			
			var list_com:gtCommand = NewCommand("list",list);
			list_com.Add_man("lists out all available commands or pass in a type for commands of a type");
		}
		
		public static function GetInstance()
		{
			if(m_instance == null)
				m_instance = new gtCommandManager;

			return m_instance;
		}
		
		public static function DeleteInstance()
		{
			m_instance = null;
		}		
		
		public function NewCommand(c:String,f:Function):gtCommand
		{
			var newCommand:gtCommand = new gtCommand();
			newCommand.Init(c,f);
			Register(newCommand);
			return newCommand;
		}
		
		public function Register(c:gtCommand)
		{
			m_commands[c.m_command] = c;
		}
		
		public function HasCommand(c:String):Boolean
		{
			return (m_commands[c] != null);
		}
		
		public function PerformCommand(c:String):String
		{
			var temp:Array = c.split("(");
			if (temp.length == 1)
				temp = c.split(" ");
			
			var command:String = temp[0];
			var parameters:String = null;
			if (temp[1])
				parameters = temp[1].split(")")[0];
			
			if (HasCommand(temp[0]))
			{
				return m_commands[command].Perform(parameters);
			}
			else
				return "Command " + command + " Not Found!";
		}
		
		public function man(p:Object)
		{
			if (p["what"])
			{
				if (HasCommand(p["what"]))
				{
					m_commands[p["what"]].man();
					return "";
				}
			}
			else
				return "man what?";
		}
		
		public function help(p:Object)
		{
			return "use \"man\" for details on commands or list to \"list\" commands";
		}
		
		public function list(p:Object)
		{
			gtLog.Add("Available Commands");
			gtLog.Add("----------------------------");
			for (var i in m_commands)
			{
				gtLog.Add(m_commands[i].m_command);
			}
			gtLog.Add("----------------------------");
			return "";
		}
	}
}