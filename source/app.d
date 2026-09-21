import std.stdio;
import raylib;

void main()
{
	validateRaylibBinding();
	InitWindow(800, 800, "windowName");
	SetTargetFPS(60);

	while (!WindowShouldClose())
	{
		BeginDrawing();
		ClearBackground(Colors.RAYWHITE);
		EndDrawing();
	}
	CloseWindow();
}
