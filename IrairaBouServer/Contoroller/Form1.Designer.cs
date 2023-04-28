
namespace Contoroller
{
	partial class Form1
	{
		/// <summary>
		///  Required designer variable.
		/// </summary>
		private System.ComponentModel.IContainer components = null;

		/// <summary>
		///  Clean up any resources being used.
		/// </summary>
		/// <param name="disposing">true if managed resources should be disposed; otherwise, false.</param>
		protected override void Dispose(bool disposing)
		{
			if (disposing && (components != null))
			{
				components.Dispose();
			}
			base.Dispose(disposing);
		}

		#region Windows Form Designer generated code

		/// <summary>
		///  Required method for Designer support - do not modify
		///  the contents of this method with the code editor.
		/// </summary>
		private void InitializeComponent()
		{
			this.LeftButton = new System.Windows.Forms.Button();
			this.RightButton = new System.Windows.Forms.Button();
			this.DownButton = new System.Windows.Forms.Button();
			this.LeftClickButton = new System.Windows.Forms.Button();
			this.UpButton = new System.Windows.Forms.Button();
			this.RightClickButton = new System.Windows.Forms.Button();
			this.Mouse_Distance_UpDown = new System.Windows.Forms.NumericUpDown();
			((System.ComponentModel.ISupportInitialize)(this.Mouse_Distance_UpDown)).BeginInit();
			this.SuspendLayout();
			// 
			// LeftButton
			// 
			this.LeftButton.Location = new System.Drawing.Point(258, 225);
			this.LeftButton.Name = "LeftButton";
			this.LeftButton.Size = new System.Drawing.Size(94, 29);
			this.LeftButton.TabIndex = 0;
			this.LeftButton.Text = "←";
			this.LeftButton.UseVisualStyleBackColor = true;
			this.LeftButton.Click += new System.EventHandler(this.LeftButton_Click);
			// 
			// RightButton
			// 
			this.RightButton.Location = new System.Drawing.Point(442, 225);
			this.RightButton.Name = "RightButton";
			this.RightButton.Size = new System.Drawing.Size(94, 29);
			this.RightButton.TabIndex = 1;
			this.RightButton.Text = "→";
			this.RightButton.UseVisualStyleBackColor = true;
			this.RightButton.Click += new System.EventHandler(this.RightButton_Click);
			// 
			// DownButton
			// 
			this.DownButton.Location = new System.Drawing.Point(350, 260);
			this.DownButton.Name = "DownButton";
			this.DownButton.Size = new System.Drawing.Size(94, 29);
			this.DownButton.TabIndex = 2;
			this.DownButton.Text = "↓";
			this.DownButton.UseVisualStyleBackColor = true;
			this.DownButton.Click += new System.EventHandler(this.DownButton_Click);
			// 
			// LeftClickButton
			// 
			this.LeftClickButton.Location = new System.Drawing.Point(258, 140);
			this.LeftClickButton.Name = "LeftClickButton";
			this.LeftClickButton.Size = new System.Drawing.Size(94, 29);
			this.LeftClickButton.TabIndex = 3;
			this.LeftClickButton.Text = "左クリック";
			this.LeftClickButton.UseVisualStyleBackColor = true;
			this.LeftClickButton.Click += new System.EventHandler(this.LeftClickButton_Click);
			// 
			// UpButton
			// 
			this.UpButton.Location = new System.Drawing.Point(350, 190);
			this.UpButton.Name = "UpButton";
			this.UpButton.Size = new System.Drawing.Size(94, 29);
			this.UpButton.TabIndex = 4;
			this.UpButton.Text = "↑";
			this.UpButton.UseVisualStyleBackColor = true;
			this.UpButton.Click += new System.EventHandler(this.UpButton_Click);
			// 
			// RightClickButton
			// 
			this.RightClickButton.Location = new System.Drawing.Point(442, 140);
			this.RightClickButton.Name = "RightClickButton";
			this.RightClickButton.Size = new System.Drawing.Size(94, 29);
			this.RightClickButton.TabIndex = 5;
			this.RightClickButton.Text = "右クリック";
			this.RightClickButton.UseVisualStyleBackColor = true;
			this.RightClickButton.Click += new System.EventHandler(this.RightClickButton_Click);
			// 
			// Mouse_Distance_UpDown
			// 
			this.Mouse_Distance_UpDown.Location = new System.Drawing.Point(606, 367);
			this.Mouse_Distance_UpDown.Name = "Mouse_Distance_UpDown";
			this.Mouse_Distance_UpDown.Size = new System.Drawing.Size(150, 27);
			this.Mouse_Distance_UpDown.TabIndex = 7;
			this.Mouse_Distance_UpDown.Value = new decimal(new int[] {
            20,
            0,
            0,
            0});
			// 
			// Form1
			// 
			this.AutoScaleDimensions = new System.Drawing.SizeF(8F, 20F);
			this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
			this.ClientSize = new System.Drawing.Size(800, 450);
			this.Controls.Add(this.Mouse_Distance_UpDown);
			this.Controls.Add(this.RightClickButton);
			this.Controls.Add(this.UpButton);
			this.Controls.Add(this.LeftClickButton);
			this.Controls.Add(this.DownButton);
			this.Controls.Add(this.RightButton);
			this.Controls.Add(this.LeftButton);
			this.Name = "Form1";
			this.Text = "Form1";
			((System.ComponentModel.ISupportInitialize)(this.Mouse_Distance_UpDown)).EndInit();
			this.ResumeLayout(false);

		}

		#endregion

		private System.Windows.Forms.Button LeftButton;
		private System.Windows.Forms.Button RightButton;
		private System.Windows.Forms.Button DownButton;
		private System.Windows.Forms.Button LeftClickButton;
		private System.Windows.Forms.Button UpButton;
		private System.Windows.Forms.Button RightClickButton;
		private System.Windows.Forms.NumericUpDown Mouse_Distance_UpDown;
	}
}

