using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using thu.Models;
using System.Text.Json;
using System.Text.Json.Serialization;

namespace Contoroller
{
	public partial class Form1 : Form
	{
		const string url = "http://118.241.148.157:25565/api/Thunkable";
		private void SendCommand(Command command)
		{
			new System.Net.Http.HttpClient().PostAsync(url, new System.Net.Http.StringContent(JsonSerializer.Serialize(command),System.Text.Encoding.UTF8, "application/json"));
		}
		public Form1()
		{
			InitializeComponent();
		}

		private void UpButton_Click(object sender, EventArgs e)
		{
			SendCommand(new Command { command = "mouse",vertical= -(double)Mouse_Distance_UpDown.Value, horizonal=0 });
		}

		private void LeftButton_Click(object sender, EventArgs e)
		{
			SendCommand(new Command { command = "mouse", vertical = 0, horizonal = -(double)Mouse_Distance_UpDown.Value });
		}

		private void RightButton_Click(object sender, EventArgs e)
		{

			SendCommand(new Command { command = "mouse", vertical = 0, horizonal = (double)Mouse_Distance_UpDown.Value });
		}

		private void DownButton_Click(object sender, EventArgs e)
		{
			SendCommand(new Command { command = "mouse", vertical = (double)Mouse_Distance_UpDown.Value, horizonal = 0 });

		}

		private void LeftClickButton_Click(object sender, EventArgs e)
		{
			SendCommand(new Command { command = "mouse_left" });

		}

		private void RightClickButton_Click(object sender, EventArgs e)
		{
			SendCommand(new Command { command = "mouse_right"});

		}
	}
}
