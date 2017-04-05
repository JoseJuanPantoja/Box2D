class Box {

  Body body;
  float w;
  float h;

  Box(float x, float y) {
    w = 30;
    h = 30;
    makeBody(new Vec2(x, y), w, h);
  }

  void killBody() {
    box2d.destroyBody(body);
  }

  boolean done() {
    if (key == 'r' || key == 'R') {
      killBody();
      return true;
    }
    return false;
  }

  void display() {
    Vec2 pos = box2d.getBodyPixelCoord(body);
    float a = body.getAngle();

    ellipseMode(CENTER);
    pushMatrix();
    px = pos.x;
    py = pos.y;
    translate(pos.x, pos.y);
    rotate(-a);
    fill(255, 103, 8);
    noStroke();
    ellipse(0, 0, w, h);    
    popMatrix();
  }

  void makeBody(Vec2 center, float w_, float h_) {

    PolygonShape sd = new PolygonShape();
    float box2dW = box2d.scalarPixelsToWorld(w_/2);
    float box2dH = box2d.scalarPixelsToWorld(h_/2);
    sd.setAsBox(box2dW, box2dH);

    FixtureDef fd = new FixtureDef();
    fd.shape = sd;
    fd.density = 1;
    fd.friction = 0.3;
    fd.restitution = 0.5;

    BodyDef bd = new BodyDef();
    bd.type = BodyType.DYNAMIC;
    bd.position.set(box2d.coordPixelsToWorld(center));

    body = box2d.createBody(bd);
    body.createFixture(fd);

    body.setLinearVelocity(new Vec2(angulo, angulo));
    body.setAngularVelocity(random(-5, 5));
  }
}