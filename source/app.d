import std.stdio;
import std.conv;
import raylib;

import packages.players;
import core.sys.windows.wingdi;
import core.sys.linux.input_event_codes;

void main()
{

	auto p1 = Player(Vector2(50, 50), Colors.RED);
	auto p2 = Player(Vector2(750, 750), Colors.BLUE);
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

		if (IsKeyPressed(KeyboardKey.KEY_R))
		{ // press 'R' for quick reset, just for testing purposes
			reset();
		}

		const speedFactor = 5.0f;

		if (IsKeyDown(KeyboardKey.KEY_D))
			if (p1.position.x < 800 - p1.radius)
				p1.position.x += speedFactor;
		if (IsKeyDown(KeyboardKey.KEY_A))
			if (p1.position.x > 0 + p1.radius)
				p1.position.x -= speedFactor;
		if (IsKeyDown(KeyboardKey.KEY_W))
			if (p1.position.y > 0 + p1.radius)
				p1.position.y -= speedFactor;
		if (IsKeyDown(KeyboardKey.KEY_S))
			if (p1.position.y < 800 - p1.radius)
				p1.position.y += speedFactor;

		if (IsKeyDown(KeyboardKey.KEY_RIGHT))
			if (p2.position.x < 800 - p2.radius)
				p2.position.x += speedFactor;
		if (IsKeyDown(KeyboardKey.KEY_LEFT))
			if (p2.position.x > 0 + p2.radius)
				p2.position.x -= speedFactor;
		if (IsKeyDown(KeyboardKey.KEY_UP))
			if (p2.position.y > 0 + p2.radius)
				p2.position.y -= speedFactor;
		if (IsKeyDown(KeyboardKey.KEY_DOWN))
			if (p2.position.y < 800 - p2.radius)
				p2.position.y += speedFactor;

		ball.checkCollisionWithPlayer(p1); // ball method
		ball.checkCollisionWithPlayer(p2);
		ball.update(); // ball method
		ball.drawBall();
		EndDrawing();
	}
	CloseWindow();
}
