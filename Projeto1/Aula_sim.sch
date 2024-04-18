<?xml version="1.0" encoding="UTF-8"?>
<drawing version="7">
    <attr value="spartan6" name="DeviceFamilyName">
        <trait delete="all:0" />
        <trait editname="all:0" />
        <trait edittrait="all:0" />
    </attr>
    <netlist>
        <signal name="DIPSW(3:0)" />
        <signal name="CLK27MHz" />
        <signal name="BUT(3:0)" />
        <signal name="XLXN_4(3:0)" />
        <signal name="GPIO(7:0)" />
        <port polarity="Input" name="DIPSW(3:0)" />
        <port polarity="Input" name="CLK27MHz" />
        <port polarity="Input" name="BUT(3:0)" />
        <port polarity="Output" name="XLXN_4(3:0)" />
        <port polarity="BiDirectional" name="GPIO(7:0)" />
        <blockdef name="AULA_1">
            <timestamp>2024-4-18T1:41:26</timestamp>
            <rect width="256" x="64" y="-192" height="192" />
            <line x2="0" y1="-160" y2="-160" x1="64" />
            <rect width="64" x="0" y="-108" height="24" />
            <line x2="0" y1="-96" y2="-96" x1="64" />
            <rect width="64" x="0" y="-44" height="24" />
            <line x2="0" y1="-32" y2="-32" x1="64" />
            <rect width="64" x="320" y="-172" height="24" />
            <line x2="384" y1="-160" y2="-160" x1="320" />
            <rect width="64" x="320" y="-44" height="24" />
            <line x2="384" y1="-32" y2="-32" x1="320" />
        </blockdef>
        <block symbolname="AULA_1" name="XLXI_1">
            <blockpin signalname="CLK27MHz" name="CLK27MHZ" />
            <blockpin signalname="DIPSW(3:0)" name="DIPSW(3:0)" />
            <blockpin signalname="BUT(3:0)" name="BUT(3:0)" />
            <blockpin signalname="XLXN_4(3:0)" name="LEDS(3:0)" />
            <blockpin signalname="GPIO(7:0)" name="GPIO(7:0)" />
        </block>
    </netlist>
    <sheet sheetnum="1" width="3520" height="2720">
        <instance x="880" y="1024" name="XLXI_1" orien="R0">
        </instance>
        <branch name="DIPSW(3:0)">
            <wire x2="880" y1="928" y2="928" x1="848" />
        </branch>
        <iomarker fontsize="28" x="848" y="928" name="DIPSW(3:0)" orien="R180" />
        <branch name="CLK27MHz">
            <wire x2="880" y1="864" y2="864" x1="848" />
        </branch>
        <iomarker fontsize="28" x="848" y="864" name="CLK27MHz" orien="R180" />
        <branch name="BUT(3:0)">
            <wire x2="880" y1="992" y2="992" x1="848" />
        </branch>
        <iomarker fontsize="28" x="848" y="992" name="BUT(3:0)" orien="R180" />
        <branch name="XLXN_4(3:0)">
            <wire x2="1296" y1="864" y2="864" x1="1264" />
        </branch>
        <iomarker fontsize="28" x="1296" y="864" name="XLXN_4(3:0)" orien="R0" />
        <branch name="GPIO(7:0)">
            <wire x2="1296" y1="992" y2="992" x1="1264" />
        </branch>
        <iomarker fontsize="28" x="1296" y="992" name="GPIO(7:0)" orien="R0" />
    </sheet>
</drawing>