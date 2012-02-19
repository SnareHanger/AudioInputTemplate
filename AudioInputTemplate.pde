import ddf.minim.*;
import ddf.minim.signals.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;

Minim minim;
AudioInput audioIn;
BeatDetect beat;
BeatListener bl;

int amplitudeMultiplier = 500;
int beatSensitivity = 10;

void setup() {
  size(1024, 512, OPENGL);

  minim = new Minim(this);

  audioIn = minim.getLineIn(Minim.STEREO, 512);

  beat = new BeatDetect(audioIn.bufferSize(), audioIn.sampleRate());
  beat.setSensitivity(beatSensitivity);

  bl = new BeatListener(beat, audioIn);
}

void draw() {
  background(0);



  for (int i = 0; i < audioIn.bufferSize(); i++) {
    if (beat.isKick()) {
      stroke(255, 0, 0);
      fill(255, 0, 0);
    } 
    else if (beat.isSnare()) {
      stroke(0, 255, 0);
      fill(0, 255, 0);
    } 
    else if (beat.isHat()) {
      stroke(0, 0, 255);
      fill(0, 0, 255);
    }
    else {
      stroke(255);
      noFill();
    }
    rect(i * 2, 256, audioIn.left.get(i)*amplitudeMultiplier, audioIn.right.get(i)*amplitudeMultiplier);
  }
}

void stop() {
  audioIn.close();
  minim.stop();
  super.stop();
}

