#include "../include/ChannelInterface.h"

ChannelInterface::ChannelInterface(int x, int y, int width, int height, 
				   const char* label): 
    Fl_Tabs(x,y,width,height,label)
{
    for(int i=0; i<4; ++i){
	string str("Channel ");
	str += lexical_cast<string>(i+1);
	labelArray_.push_back(str);
    }

    for(int i=0; i<4; ++i){
	ChannelGroupPtr ptr(new ChannelGroup(x+15,y+25,200,100,labelArray_[i].c_str()));
	channelArray_.push_back(ptr);
	this->add(channelArray_[i].get());
    }
    this->end();
};
