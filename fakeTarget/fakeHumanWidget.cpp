#include "fakeHumanWidget.h"

class ControlWidget : public QWidget
{
	Q_OBJECT

public:
	ControlWidget(QDesktopWidget * qdw);
	
private:
	QSpinBox *trialNumBox;
	QPushButton *startButton; 	
	QFormLayout * layout;
		
	DisplayWidget * userWidget;

	void closeEvent(QCloseEvent *event);
	
	QByteArray in,out;
	int inSize, outSize;
	QUdpSocket * us;
	
	enum ProbeType {NONE=0, VISCOUSITY=1, PULSE=2} probe;

	timespec zero, now;
	point center, pos, vel, accel, force;
	
signals:
	void endApp();
	
public slots:
	void readPending(); //Update delay value
	void startClicked();
};

#endif
