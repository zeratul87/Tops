all: FactorizedJetCorrector.o JetCorrectorParameters.o SimpleJetCorrector.o JetCorrectionUncertainty.o

clean:
	rm FactorizedJetCorrector.o JetCorrectorParameters.o SimpleJetCorrector.o JetCorrectionUncertainty.o SimpleJetCorrectionUncertainty.o

FactorizedJetCorrector.o: FactorizedJetCorrector.cc FactorizedJetCorrector.h JetCorrectorParameters.h SimpleJetCorrector.h Utilities.cc
	g++ -O2 -c -fPIC -std=c++11 `root-config --libs` -I`root-config --incdir` FactorizedJetCorrector.cc

JetCorrectorParameters.o: JetCorrectorParameters.cc JetCorrectorParameters.h 
	g++ -O2 -c -fPIC -std=c++11 `root-config --libs` -I`root-config --incdir` JetCorrectorParameters.cc

SimpleJetCorrector.o: JetCorrectorParameters.cc JetCorrectorParameters.h SimpleJetCorrector.h
	g++ -O2 -c -fPIC -std=c++11 `root-config --libs` -I`root-config --incdir` SimpleJetCorrector.cc 

JetCorrectionUncertainty.o: JetCorrectionUncertainty.cc JetCorrectionUncertainty.h SimpleJetCorrectionUncertainty.cc SimpleJetCorrectionUncertainty.h
	g++ -O2 -c -fPIC -std=c++11 `root-config --libs` -I`root-config --incdir` JetCorrectionUncertainty.cc SimpleJetCorrectionUncertainty.cc 
 
