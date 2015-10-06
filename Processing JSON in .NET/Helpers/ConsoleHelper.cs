namespace HomeworkHelpers
{
    using System;

    public class ConsoleHelper
    {
        public void Setup(
            ConsoleColor color = ConsoleColor.Black
            , ConsoleColor background = ConsoleColor.White
            , int windowWidth = 120)
        {
            try
            {
                Console.BackgroundColor = background;
                Console.ForegroundColor = color;
                Console.OutputEncoding = System.Text.Encoding.Unicode;
                Console.SetWindowSize(windowWidth, Console.WindowHeight);
            }
            catch (Exception)
            {
                // Prevent Crashing if Console can't take any of the parameters
            }
            finally
            {
                Console.Clear();
            }
        }

        public void Restart(Action restartCallback)
        {
            Console.WriteLine();
            this.PrintHeading("PRESS ANY KEY TO RESTART or Ctrl + C to exit");
            Console.CursorVisible = false;
            Console.ReadKey(true);
            Console.CursorVisible = true;

            restartCallback(); 
        }

        public void Write(string text, ConsoleColor color)
        {
            var previousColor = Console.ForegroundColor;
            Console.ForegroundColor = color;

            Console.Write(text);

            Console.ForegroundColor = previousColor;
        }

        public void Write(string text, ConsoleColor color, params object[] args)
        {
            this.Write(string.Format(text, args), color);
        }

        public void Write(string text, ConsoleColor color, ConsoleColor background)
        {
            var previousBackground = Console.BackgroundColor;
            Console.BackgroundColor = background;

            this.Write(text, color);

            Console.BackgroundColor = previousBackground;
        }

        public void WriteLine(string text, ConsoleColor color)
        {
            this.Write(text, color);
            Console.WriteLine();
        }

        public void WriteLine(string text, ConsoleColor color, params object[] args)
        {
            this.WriteLine(string.Format(text, args), color);
        }

        public string ReadInColor(ConsoleColor color)
        {
            var previousColor = Console.ForegroundColor;

            Console.ForegroundColor = color;
            string input = Console.ReadLine();

            Console.ForegroundColor = previousColor;

            return input;
        }

        public void PrintHeading(string text, ConsoleColor color = ConsoleColor.White)
        {
            int totalWidth = Console.WindowWidth;
            string format = string.Format(" {0} ", text);
            char paddingChar = ' ';
            var paddingColor = ConsoleColor.White;
            var backgorundColor = ConsoleColor.DarkGray;
            int freeWidth = totalWidth - format.Length;

            this.Write(new string(paddingChar, totalWidth), paddingColor, backgorundColor);
            this.Write(new string(paddingChar, freeWidth / 2), paddingColor, backgorundColor);
            this.Write(format, color, backgorundColor);
            this.Write(new string(paddingChar, freeWidth / 2), paddingColor, backgorundColor);
            this.Write(new string(paddingChar, totalWidth), paddingColor, backgorundColor);
            Console.WriteLine();
            Console.WriteLine();
        }
    }
}
