using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using iraira.Models;
using System.Runtime.InteropServices;
using System.Text.Json;

namespace iraira.Controllers
{
	[ApiController]
	[Route("")]
	public class IrairaController : ControllerBase
	{
		private readonly ILogger<IrairaController> _logger;
		static private int up = 0;
		static private int down = 0;
		static private int right = 0;
		static private int left = 0;

		public IrairaController(ILogger<IrairaController> logger)
		{
			_logger = logger;
		}

		[HttpGet]
		public string Get()
		{
			System.Console.WriteLine("GETを受信！");
			Dictionary<string, int> temp = new(){ { "up", up }, { "down", down }, { "right", right }, { "left", left } };
			var json = JsonSerializer.Serialize(temp, new JsonSerializerOptions());
			up = 0;
			down = 0;
			right = 0;
			left = 0;
			return json;
		}
		[HttpPost]
		public string CommandResieved(Command command)
		{
			System.Console.WriteLine($"{command.direction}を受信");
			if (command.direction == "up")
			{
				up++;
			}
			else if (command.direction == "down")
			{
				down++;
			}
			else if (command.direction == "right")
			{
				right++;
			}
			else if (command.direction == "left")
			{
				left++;
			}
			return "";
		}
	}
}
