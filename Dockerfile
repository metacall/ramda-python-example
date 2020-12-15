#
#	MetaCall Ramda Python Example by Parra Studios
#	An example of using Ramda (JavaScript) from Python..
#
#	Copyright (C) 2016 - 2021 Vicente Eduardo Ferrer Garcia <vic798@gmail.com>
#
#	Licensed under the Apache License, Version 2.0 (the "License");
#	you may not use this file except in compliance with the License.
#	You may obtain a copy of the License at
#
#		http://www.apache.org/licenses/LICENSE-2.0
#
#	Unless required by applicable law or agreed to in writing, software
#	distributed under the License is distributed on an "AS IS" BASIS,
#	WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#	See the License for the specific language governing permissions and
#	limitations under the License.
#

FROM alpine:latest

# Image descriptor
LABEL copyright.name="Vicente Eduardo Ferrer Garcia" \
	copyright.address="vic798@gmail.com" \
	maintainer.name="Vicente Eduardo Ferrer Garcia" \
	maintainer.address="vic798@gmail.com" \
	vendor="MetaCall Inc." \
	version="0.1"

# Set up working directory
WORKDIR /metacall

# Install certificates
RUN apk update \
	&& apk add ca-certificates curl

# Invalidate Cache
ARG CACHE_INVALIDATE

# Install MetaCall Core
RUN echo "${CACHE_INVALIDATE}" \
	&& curl -sL https://raw.githubusercontent.com/metacall/install/master/install.sh | sh

# Copy dependencies
COPY . /metacall/

# Install dependencies
RUN metacall npm install \
	&& metacall pip3 install -r requirements.txt

# Run command
CMD [ "metacall", "index.py" ]