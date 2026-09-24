import std.stdio;
import std.conv;
import raylib;
import packages.players;
import std.math;

void main()
{
	auto p1 = Player(Vector2(400, 90), Colors.RED);
	auto p2 = Player(Vector2(400, 710), Colors.BLUE);
	auto ball = Ball();

	validateRaylibBinding();
	InitWindow(800, 800, "Game");
	SetTargetFPS(60);

	while (!WindowShouldClose())
	{
		BeginDrawing();
		ClearBackground(Colors.BLACK);
		DrawLine(0, 400, 800, 400, Colors.GRAY); //Midpoint line and circle
        DrawCircleLines(400, 400, 150, Colors.GRAY);

		DrawLine(250, 1, 550, 1, Colors.GREEN); //Top goal line and box
        DrawRectangleLines(250, 1, 300, 90, Colors.GRAY);

		DrawLine(250, 799, 550, 799, Colors.GREEN); //Bottom goal line and box
        DrawRectangleLines(250, 799, 300, -90, Colors.GRAY);

		p1.drawPlayer(); //red player
		p2.drawPlayer(); //blue player
		ball.drawBall();

		DrawText(TextFormat("RED:%2i", p1.points), 20, 360, 20, Colors.RED); // Score keeping text, middle left
		DrawText(TextFormat("BLUE:%2i", p2.points), 20, 420, 20, Colors.BLUE);

		if (IsKeyPressed(KeyboardKey.KEY_R))
		{
			reset(p1, p2, ball);
		}

		const speedFactor = 7;

		if (IsKeyDown(KeyboardKey.KEY_D))
			if (p1.position.x < 800 - p1.radius)
			{
				if (sqrt((p1.position.x - ball.position.x) ^^ 2 + (
						p1.position.y - ball.position.y) ^^ 2) >= 80)
				{
					p1.position.x += speedFactor;
				}
				else
				{
					if ((p1.position - ball.position).y > 0)
					{
						p1.position.y += 1;
					}
					else
					{
						p1.position.y -= 1;
					}
				}
			}

		if (IsKeyDown(KeyboardKey.KEY_A))
			if (p1.position.x > 0 + p1.radius)
			{
				if (sqrt((p1.position.x - ball.position.x) ^^ 2 + (
						p1.position.y - ball.position.y) ^^ 2) >= 80)
				{
					p1.position.x -= speedFactor;
				}
				else
				{
					if ((p1.position - ball.position).y > 0)
					{
						p1.position.y += 1;
					}
					else
					{
						p1.position.y -= 1;
					}
				}
			}

		if (IsKeyDown(KeyboardKey.KEY_W))
			if (p1.position.y > 0 + p1.radius)
			{
				if (sqrt((p1.position.x - ball.position.x) ^^ 2 + (
						p1.position.y - ball.position.y) ^^ 2) >= 80)
				{
					p1.position.y -= speedFactor;
				}
				else
				{
					if ((p1.position - ball.position).x > 0)
					{
						p1.position.x += 1;
					}
					else
					{
						p1.position.x -= 1;
					}
				}
			}
		if (IsKeyDown(KeyboardKey.KEY_S))
			if (p1.position.y < 400 - p1.radius)
			{
				if (sqrt((p1.position.x - ball.position.x) ^^ 2 + (
						p1.position.y - ball.position.y) ^^ 2) >= 80)
				{
					p1.position.y += speedFactor;
				}
				else
				{
					p1.position.y -= 1;
				}
			}

		if (IsKeyDown(KeyboardKey.KEY_RIGHT))
			if (p2.position.x < 800 - p2.radius)
			{
				if (sqrt((p2.position.x - ball.position.x) ^^ 2 + (
						p2.position.y - ball.position.y) ^^ 2) >= 80)
				{
					p2.position.x += speedFactor;
				}
				else
				{
					p2.position.x -= 1;
					if ((p2.position - ball.position).y > 0)
					{
						p2.position.y += 1;
					}
					else
					{
						p2.position.y -= 1;
					}
				}
			}

		if (IsKeyDown(KeyboardKey.KEY_LEFT))
			if (p2.position.x > 0 + p2.radius)
			{
				if (sqrt((p2.position.x - ball.position.x) ^^ 2 + (
						p2.position.y - ball.position.y) ^^ 2) >= 80)
				{
					p2.position.x -= speedFactor;
				}
				else
				{
					p2.position.x += 1;
					if ((p2.position - ball.position).y > 0)
					{
						p2.position.y += 1;
					}
					else
					{
						p2.position.y -= 1;
					}
				}
			}

		if (IsKeyDown(KeyboardKey.KEY_UP))
			if (p2.position.y > 400 + p2.radius)
			{
				if (sqrt((p2.position.x - ball.position.x) ^^ 2 + (
						p2.position.y - ball.position.y) ^^ 2) >= 80)
				{
					p2.position.y -= speedFactor;
				}
				else
				{
					p2.position.y += 1;

					if ((p2.position - ball.position).x > 0)
					{
						p2.position.x += 1;
					}
					else
					{
						p2.position.x -= 1;
					}
				}
			}

		if (IsKeyDown(KeyboardKey.KEY_DOWN))
			if (p2.position.y < 800 - p2.radius)
			{
				if (sqrt((p2.position.x - ball.position.x) ^^ 2 + (
						p2.position.y - ball.position.y) ^^ 2) >= 80)
				{
					p2.position.y += speedFactor;
				}
				else
				{
					p2.position.y -= 1;
					if ((p2.position - ball.position).x > 0)
					{
						p2.position.x += 1;
					}
					else
					{
						p2.position.x -= 1;
					}
				}
			}

		ball.checkCollisionWithPlayer(p1);
		ball.checkCollisionWithPlayer(p2);
		ball.update(p1, p2);
		EndDrawing();
	}

	CloseWindow();
}
