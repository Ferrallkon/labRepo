import std.stdio;
import std.conv;
import raylib;

import packages.players;
import core.sys.windows.wingdi;
import core.sys.linux.input_event_codes;

void main()
{

	auto p1 = Player(Vector2(10, 10), Colors.RED);
	auto p2 = Player(Vector2(690, 740), Colors.BLUE);
	auto ball = Ball();

	validateRaylibBinding();
	InitWindow(800, 800, "Game");
	SetTargetFPS(60);

	void reset()
	{
		p1.position = Vector2(10, 10);
		p2.position = Vector2(690, 740);
		ball.position = Vector2(400.0f, 400.0f);
		ball.speed = Vector2(0.0f, 0.0f);
	}

	while (!WindowShouldClose())
	{
		BeginDrawing();
		ClearBackground(Colors.RAYWHITE);

		p1.drawPlayer();
		p2.drawPlayer();

		ball.drawBall(); // ball method

		ball.drawBall(); // ball method

		if (IsKeyPressed(KeyboardKey.KEY_R))
		{ // press 'R' for quick reset, just for testing purposes
			reset();
		}

		if (IsKeyDown(KeyboardKey.KEY_D))
			p1.position.x += 2.0f;
		if (IsKeyDown(KeyboardKey.KEY_A))
			p1.position.x -= 2.0f;
		if (IsKeyDown(KeyboardKey.KEY_W))
			p1.position.y -= 2.0f;
		if (IsKeyDown(KeyboardKey.KEY_S))
			p1.position.y += 2.0f;

		if (IsKeyDown(KeyboardKey.KEY_RIGHT))
			p2.position.x += 2.0f;
		if (IsKeyDown(KeyboardKey.KEY_LEFT))
			p2.position.x -= 2.0f;
		if (IsKeyDown(KeyboardKey.KEY_UP))
			p2.position.y -= 2.0f;
		if (IsKeyDown(KeyboardKey.KEY_DOWN))
			p2.position.y += 2.0f;

		// // convert players to Rectangle to use CheckCollisionCircleRec()
		auto p1rec = Rectangle(p1.position.x, p1.position.y, p1.size.x, p1.size.y);
		auto p2rec = Rectangle(p2.position.x, p2.position.y, p2.size.x, p2.size.y);

		ball.checkCollisionWithPlayer(p1rec); // ball method
		ball.checkCollisionWithPlayer(p2rec);
		ball.update(); // ball method
		ball.drawBall();

		EndDrawing();
	}
	CloseWindow();
}
