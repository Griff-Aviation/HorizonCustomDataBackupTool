namespace gui
{
    public partial class Form1 : Form
    {
        public Form1()
        {
            InitializeComponent();
        }

        private void button1_Click(object sender, EventArgs e)
        {
            using (var dialog = new System.Windows.Forms.FolderBrowserDialog())
            {
                System.Windows.Forms.DialogResult result = dialog.ShowDialog();
                textBox1.Text = dialog.SelectedPath.ToString();
            }
        }

        private void label1_Click(object sender, EventArgs e)
        {

        }

        private void button2_Click(object sender, EventArgs e)
        {
            label2.Text = "Running backup.";
            string strCmdLine = ".\\moveConfig.ps1 backup " + textBox1.Text.ToString();
            System.Diagnostics.Process process = new System.Diagnostics.Process();
            process.StartInfo.UseShellExecute = true;
            process.StartInfo.Verb = "runas";
            process.StartInfo.FileName = "powershell.exe";
            process.StartInfo.Arguments = strCmdLine;
            process.Start();
            process.WaitForExit();
            process.Close();
            label2.Text = "Finished backup.";
        }

        private void button3_Click(object sender, EventArgs e)
        {
            label2.Text = "Running restore.";
            string strCmdLine = "/C cmd.exe .\\moveConfig.ps1 restore " + textBox1.Text.ToString();
            if(checkBox1.Checked)
            {
                strCmdLine += " -clean";
            }
            System.Diagnostics.Process process = new System.Diagnostics.Process();
            process.StartInfo.UseShellExecute = true;
            process.StartInfo.Verb = "runas";
            process.StartInfo.FileName = "powershell.exe";
            process.StartInfo.Arguments = strCmdLine;
            process.Start();
            process.WaitForExit();
            process.Close();
            label2.Text = "Finished restore.";
        }

        private void checkBox1_CheckedChanged(object sender, EventArgs e)
        {

        }

        private void Form1_Load(object sender, EventArgs e)
        {

        }
    }
}