import { Icon } from "@chakra-ui/react";
import { Locations } from "@/hooks/state";

export const Markers = ({ location }: { location: Locations }) => {
  return (
    <Icon
      layerStyle="fill"
      zIndex="overlay"
      viewBox="0 0 256 256"
      xmlns="http://www.w3.org/2000/svg"
    >
      <g visibility={Locations.Central != location ? "visibile" : "hidden"}>
        <path
          d="M120 115.996H124.01V116.996H125.01V121.006H124.01V122.006H120V121.006H119V116.996H120V115.996Z"
          fill="#172217"
        />
        <path
          fillRule="evenodd"
          clipRule="evenodd"
          d="M120 114.996H124.01V115.996H125.01V116.996H126.01V121.006H125.01V122.006H124.01V123.006H120V122.006H119V121.006H118V116.996H119V115.996H120V114.996ZM124 121.996V120.996H125V117.006H124V116.006H120.01V117.006H119.01V120.996H120.01V121.996H124Z"
          fill="#0CA85D"
        />
      </g>
      <g visibility={Locations.Brooklyn != location ? "visibile" : "hidden"}>
        <path
          d="M117 181.994H121.01V182.994H122.01V187.004H121.01V188.004H117V187.004H116V182.994H117V181.994Z"
          fill="#172217"
        />
        <path
          fillRule="evenodd"
          clipRule="evenodd"
          d="M117 180.994H121.01V181.994H122.01V182.994H123.01V187.004H122.01V188.004H121.01V189.004H117V188.004H116V187.004H115V182.994H116V181.994H117V180.994ZM121 187.994V186.994H122V183.004H121V182.004H117.01V183.004H116.01V186.994H117.01V187.994H121Z"
          fill="#0CA85D"
        />
      </g>
      <g visibility={Locations.Coney != location ? "visibile" : "hidden"}>
        <path
          d="M191.009 202.999H195.019V203.999H196.019V208.009H195.019V209.009H191.009V208.009H190.009V203.999H191.009V202.999Z"
          fill="#172217"
        />
        <path
          fillRule="evenodd"
          clipRule="evenodd"
          d="M191.009 201.999H195.019V202.999H196.019V203.999H197.019V208.009H196.019V209.009H195.019V210.009H191.009V209.009H190.009V208.009H189.009V203.999H190.009V202.999H191.009V201.999ZM195.009 208.999V207.999H196.009V204.009H195.009V203.009H191.019V204.009H190.019V207.999H191.019V208.999H195.009Z"
          fill="#0CA85D"
        />
      </g>
      <g visibility={Locations.Queens != location ? "visibile" : "hidden"}>
        <path
          d="M188.004 134.993H192.014V135.993H193.014V140.003H192.014V141.003H188.004V140.003H187.004V135.993H188.004V134.993Z"
          fill="#172217"
        />
        <path
          fillRule="evenodd"
          clipRule="evenodd"
          d="M188.004 133.993H192.014V134.993H193.014V135.993H194.014V140.003H193.014V141.003H192.014V142.003H188.004V141.003H187.004V140.003H186.004V135.993H187.004V134.993H188.004V133.993ZM192.004 140.993V139.993H193.004V136.003H192.004V135.003H188.014V136.003H187.014V139.993H188.014V140.993H192.004Z"
          fill="#0CA85D"
        />
      </g>

      <g visibility={Locations.Bronx != location ? "visibile" : "hidden"}>
        <path
          d="M136 43.9938H140.01V44.9938H141.01V49.0038H140.01V50.0038H136V49.0038H135V44.9938H136V43.9938Z"
          fill="#172217"
        />
        <path
          fillRule="evenodd"
          clipRule="evenodd"
          d="M136 42.9938H140.01V43.9938H141.01V44.9938H142.01V49.0038H141.01V50.0038H140.01V51.0038H136V50.0038H135V49.0038H134V44.9938H135V43.9938H136V42.9938ZM140 49.9938V48.9938H141V45.0038H140V44.0038H136.01V45.0038H135.01V48.9938H136.01V49.9938H140Z"
          fill="#0CA85D"
        />
      </g>
      <g visibility={Locations.Jersey != location ? "visibile" : "hidden"}>
        <path
          d="M70.0061 96.995H74.0161V97.995H75.0161V102.005H74.0161V103.005H70.0061V102.005H69.0061V97.995H70.0061V96.995Z"
          fill="#172217"
        />
        <path
          fillRule="evenodd"
          clipRule="evenodd"
          d="M70.0061 95.995H74.0161V96.995H75.0161V97.995H76.0161V102.005H75.0161V103.005H74.0161V104.005H70.0061V103.005H69.0061V102.005H68.0061V97.995H69.0061V96.995H70.0061V95.995ZM74.0061 102.995V101.995H75.0061V98.005H74.0061V97.005H70.0161V98.005H69.0161V101.995H70.0161V102.995H74.0061Z"
          fill="#0CA85D"
        />
      </g>
    </Icon>
  );
};